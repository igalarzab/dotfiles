import os
import subprocess


def export_env_to_launchctl(baseline_env: set[str]) -> None:
    """Export custom env vars to launchctl for graphical apps (macOS).

    Build args: launchctl setenv KEY1 val1 KEY2 val2 ...

    Args:
        baseline_env: Set of env var names that existed before dotfiles loaded.
    """
    args = ['launchctl', 'setenv']

    for var in set(os.environ.keys()) - baseline_env:
        if not var.startswith('_'):  # Skip private vars
            args.extend([var, os.environ[var]])

    if len(args) > 2:
        subprocess.run(args, check=False)
