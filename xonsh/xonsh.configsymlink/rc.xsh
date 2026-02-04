import builtins, pathlib

# Update os.environ if a new env var is set
$UPDATE_OS_ENVIRON = True

# Capture baseline env vars before sourcing dotfiles
import os
_baseline_env = set(os.environ.keys())

# Auto-pair symbols (parenthesis, brackets, ...)
$XONSH_AUTOPAIR = True

# Path of where the dotfiles are located
$DOTFILES = pathlib.Path(__file__).resolve(strict=True).parents[2]

# Set US English as the language 
$LC_ALL = 'en_US.UTF-8'
$LANG = 'en_US.UTF-8'

# Configure history
$XONSH_HISTORY_BACKEND = 'sqlite'
$HISTCONTROL = 'ignoredups'

# Add few extra paths to the default PATH
$PATH.add(p'/usr/local/bin', front=True, replace=True)
$PATH.add($DOTFILES / 'bin', front=True, replace=True)

# Load env.xsh files first
for f in g`$DOTFILES/*/env.xsh`:
    source @(f)

# Load all other .xsh files
for f in g`$DOTFILES/*/*.xsh`:
    if not f.endswith('env.xsh'):
        source @(f)

# Keeping secrets in ~/.local.xsh
if p'~/.local.xsh'.exists():
    source @(p'~/.local.xsh')

# Export custom env vars to launchctl for graphical apps (macOS)
# Not ideal because it requires me to open a shell first, but better than nothing
source @(pathlib.Path(__file__).parent / 'utils.xsh')
export_env_to_launchctl(_baseline_env - {'PATH'})
del _baseline_env

# Make JSON parsable... a bit hacky, but super convenient to paste JSON in the shell
builtins.true = True
builtins.false = False
builtins.null = None
