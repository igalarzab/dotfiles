# AGENTS

dotfiles, one topic directory per tool, deployed with dotbot.

## Commands

* `./install links` links only. Offline, ~0.2s. Use it to check your changes.
* `./install` also does packages, runtimes and macOS defaults. Networked and slow.
* `--dry-run` previews, `-v` also logs what was already correct.
* dotbot reports only changes and problems. Silence means converged, not broken.

## Adding a config

Give the file or directory a suffix and it is linked automatically.

* `*.symlink` to `~/.*`
* `*.configsymlink` to `~/.config/*`
* `*.codexsymlink` to `~/.codex/*`
* `*.launchagent` to `~/Library/LaunchAgents/*.plist`

## Never run `git clean -x` in this repo

`~/.ssh`, `~/.kube` and `~/.config/git` are symlinks into this working tree, so live
state lives in gitignored files inside the repo: `known_hosts`, the ssh `agent/`
directory, the kubeconfig, `config-local`, `allowed-signers`. `git clean -x` targets
exactly those and there is no backup.

## dotbot

Setup lives in `dotbot/`. One local plugin, `dotbot/plugins/regexlink.py`, implements
the suffix convention above. Everything else uses stock directives.

`shell` has no condition support and silently drops unknown keys, so an `if:` written
there fails open and runs the command anyway. Put guards inside the command instead.

The `install` wrapper sets two things. Calling dotbot directly without them fails in
confusing ways:

* `-d <repo root>`. Configs live in `dotbot/`, and without `-d` dotbot bases itself on
  the config's own directory, so `regexlink` walks `dotbot/` and matches nothing.
* `SHELL=/bin/bash`. dotbot passes `executable=$SHELL` to `subprocess`. The login shell
  here is xonsh, which cannot parse bash `if/fi` blocks or `VAR=x cmd` prefixes.

Plugins are Python 3.14. Lint with `uvx ruff check --select UP,F,E,W,I,B,SIM dotbot/plugins/`
