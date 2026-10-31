"""Exercise the real link installer in temporary homes without installing packages."""

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class PortabilityTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.home = Path(self.temp.name)
        self.bin = self.home / "bin"
        self.bin.mkdir()
        self.env = dict(os.environ, HOME=str(self.home), PATH=f"{self.bin}:/usr/bin:/bin")
        # The vendored submodule is already present; don't mutate Git metadata.
        self.script("git", "exit 0")
        self.script("launchctl", 'echo "$*" >> "$HOME/launchctl.log"')

    def script(self, name, body):
        path = self.bin / name
        path.write_text(f"#!/bin/bash\n{body}\n")
        path.chmod(0o755)

    def install(self, *args):
        result = subprocess.run(
            ["./install", "links", *args], cwd=ROOT, env=self.env,
            text=True, capture_output=True,
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        return result

    def test_linux_links_are_idempotent_and_skip_macos(self):
        self.script("uname", 'if [ "$1" = -s ]; then echo Linux; else echo pandora; fi')
        self.install()
        self.install()
        self.assertTrue((self.home / ".config/xonsh").is_symlink())
        self.assertTrue((self.home / ".ssh").is_symlink())
        self.assertFalse((self.home / ".config/docker").exists())
        self.assertFalse((self.home / "Library").exists())
        self.assertFalse((self.home / "launchctl.log").exists())

    def test_macos_still_links_docker_and_loads_launchagents(self):
        self.script("uname", 'if [ "$1" = -s ]; then echo Darwin; else echo Titan; fi')
        self.install()
        self.assertTrue((self.home / ".config/docker").is_symlink())
        agent = self.home / "Library/LaunchAgents/com.example.KeyRemapping.plist"
        self.assertTrue(agent.is_symlink())
        self.assertIn("bootstrap gui/", (self.home / "launchctl.log").read_text())

    def test_dry_run_does_not_create_links(self):
        self.install("--dry-run")
        self.assertFalse((self.home / ".config").exists())
        self.assertFalse((self.home / ".ssh").exists())
        self.assertFalse((self.home / "Library").exists())

    def test_existing_ssh_directory_is_preserved(self):
        ssh = self.home / ".ssh"
        ssh.mkdir()
        key = ssh / "existing-key"
        key.write_text("preserve me")
        result = subprocess.run(
            ["./install", "links"], cwd=ROOT, env=self.env, capture_output=True,
        )
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(ssh.is_symlink())
        self.assertEqual(key.read_text(), "preserve me")

    def test_runtime_directory_is_preserved(self):
        runtime = self.home / "runtime"
        runtime.mkdir()
        result = subprocess.run(
            ["bash", "-c", '. shells/pre-init.sh; printf "%s" "$XDG_RUNTIME_DIR"'],
            cwd=ROOT, env=dict(self.env, XDG_RUNTIME_DIR=str(runtime)),
            text=True, capture_output=True, check=True,
        )
        self.assertEqual(result.stdout, str(runtime))

    def test_homebrew_uses_discovered_installation(self):
        self.script("brew", 'test "$*" = "shellenv bash" || exit 1; echo "export HOMEBREW_PREFIX=/test/brew"')
        result = subprocess.run(
            ["bash", "-c", '. homebrew/env.sh; printf "%s" "$HOMEBREW_PREFIX"'],
            cwd=ROOT, env=self.env, text=True, capture_output=True, check=True,
        )
        self.assertEqual(result.stdout, "/test/brew")


if __name__ == "__main__":
    unittest.main()
