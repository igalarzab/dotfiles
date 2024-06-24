import builtins

# Update os.environ if a new env var is set
$UPDATE_OS_ENVIRON = True

# Auto-pair symbols (parenthesis, brackets, ...)
$XONSH_AUTOPAIR = True

# Hide errors...
$XONSH_SHOW_TRACEBACK = False

# Path of where the dotfiles are located
$DOTFILES = p'~/.dotfiles'

# Set british as my language 
$LC_ALL = 'en_GB.UTF-8'
$LANG = 'en_GB.UTF-8'

# Configure history
$XONSH_HISTORY_BACKEND = 'sqlite'
$HISTCONTROL = 'ignoredups'

# Add homebrew and dotfiles to the default PATH
$PATH.add(p'/usr/local/bin', front=True, replace=True)
$PATH.add(p'/opt/homebrew/sbin', front=True, replace=True)
$PATH.add(p'/opt/homebrew/bin', front=True, replace=True)
$PATH.add($DOTFILES / 'bin', front=True, replace=True)

# Load all the xsh files into the shell
for f in g`$DOTFILES/*/*.xsh`:
    source @(f)

# Keeping secrets in ~/.localrc
if p'~/.local.xsh'.exists():
    source @(p'~/.local.xsh')

# Make JSON parsable... a bit hacky, but super convenient to paste JSON in the shell
builtins.true = True
builtins.false = False
builtins.null = None
