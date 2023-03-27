from pathlib import Path
from importlib.metadata import version

# Check if the package is there, otherwise install it
try:
    version("xontrib-vox")
except:
    print("Installing xontrib-vox...")
    xpip install xontrib-vox

# Load the plugins
xontrib load vox autovox

@events.autovox_policy
def dotvenv_policy(path, **_):
    gitdir = path / '.git'
    if gitdir.exists() and gitdir.is_dir():
        venv = p'~/.virtualenvs' / path.name
        if venv.exists():
            return venv
