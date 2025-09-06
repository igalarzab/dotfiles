import builtins

# Update os.environ if a new env var is set
$UPDATE_OS_ENVIRON = True

# Auto-pair symbols (parenthesis, brackets, ...)
$XONSH_AUTOPAIR = True

# Path of where the dotfiles are located
$DOTFILES = p'~/.config/dotfiles'

# Set US English as the language 
$LC_ALL = 'en_US.UTF-8'
$LANG = 'en_US.UTF-8'

# Configure history
$XONSH_HISTORY_BACKEND = 'sqlite'
$HISTCONTROL = 'ignoredups'

# Add homebrew and dotfiles to the default PATH
$PATH.add(p'/usr/local/bin', front=True, replace=True)
$PATH.add(p'/opt/homebrew/sbin', front=True, replace=True)
$PATH.add(p'/opt/homebrew/bin', front=True, replace=True)
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

# Make JSON parsable... a bit hacky, but super convenient to paste JSON in the shell
builtins.true = True
builtins.false = False
builtins.null = None
