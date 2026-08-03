import builtins
import pathlib
import os

from utils import __export_env_to_launchctl

# Enable vi mode
$VI_MODE = True

# Update os.environ if a new env var is set
$UPDATE_OS_ENVIRON = True

# Capture baseline env vars before sourcing dotfiles
__baseline_env = set(os.environ.keys())

# Path where dotfiles are stored
$DOTFILES = pathlib.Path(__file__).resolve(strict=True).parents[2]

source-bash --overwrite-aliases @($DOTFILES / 'shells' / 'pre-init.sh')

# Auto-pair symbols (parenthesis, brackets, ...)
$XONSH_AUTOPAIR = True

# Search through dot files too when globbing
$DOTGLOB=True

# Configure history
$XONSH_HISTORY_BACKEND = 'sqlite'
$HISTCONTROL = 'ignoredups'

# Load shared environment files through Bash.
for f in sorted($DOTFILES.glob('*/env.sh')):
    source-bash --overwrite-aliases @(f)

# Load shared setup files through Bash.
for f in sorted($DOTFILES.glob('*/init.sh')):
    source-bash --overwrite-aliases @(f)

# Load Xonsh-specific setup.
for f in sorted($DOTFILES.glob('*/*.xsh')):
    source @(f)

# Keeping secrets in ~/.config/local.sh
if p'~/.config/local.sh'.exists():
    source-bash @(p'~/.config/local.sh')

# Export custom env vars to launchctl for graphical apps (macOS)
# Not ideal because it requires me to open a shell first, but better than nothing
__export_env_to_launchctl(__baseline_env)
del __baseline_env

# Make JSON parsable... a bit hacky, but super convenient to paste JSON in the shell
builtins.true = True
builtins.false = False
builtins.null = None
