import builtins
import pathlib
import os

from utils import __export_env_to_launchctl
from perf import __perf_mark

__perf_mark("xonshrc start")

# Update os.environ if a new env var is set
$UPDATE_OS_ENVIRON = True

# Capture baseline env vars before sourcing dotfiles
__baseline_env = set(os.environ.keys())

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
    __perf_mark(f"loading env file: {f}")
    source @(f)

# Load all other .xsh files
for f in g`$DOTFILES/*/*.xsh`:
    if not f.endswith('env.xsh'):
        __perf_mark(f"loading config file: {f}")
        source @(f)

# Keeping secrets in ~/.local.xsh
if p'~/.local.xsh'.exists():
    __perf_mark("loading local secrets file")
    source @(p'~/.local.xsh')

# Export custom env vars to launchctl for graphical apps (macOS)
# Not ideal because it requires me to open a shell first, but better than nothing
__perf_mark("exporting env to launchctl")
__export_env_to_launchctl(__baseline_env - {'PATH'})

# Make JSON parsable... a bit hacky, but super convenient to paste JSON in the shell
builtins.true = True
builtins.false = False
builtins.null = None

__perf_mark("xonshrc end")