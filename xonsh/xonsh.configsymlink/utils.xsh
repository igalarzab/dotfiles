import os
import subprocess
import sys


def __export_env_to_launchctl(baseline_env: set[str]) -> None:
    """Export custom env vars to launchctl for graphical apps (macOS).

    Build args: launchctl setenv KEY1 val1 KEY2 val2 ...

    Args:
        baseline_env: Set of env var names that existed before dotfiles loaded.
    """
    if sys.platform != "darwin":
        return

    for var in set(os.environ.keys()) - baseline_env:
        if var.startswith('_'):
            continue

        subprocess.run(['launchctl', 'setenv', var, os.environ[var]], check=False)

    # Finish with $PATH
    subprocess.run(['launchctl', 'setenv', 'PATH', ':'.join($PATH)], check=False)
