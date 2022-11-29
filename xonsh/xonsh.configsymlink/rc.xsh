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
$PATH.add(p'/usr/local/bin', front=False, replace=True)
$PATH.add(pf'{$DOTFILES}/bin', front=False, replace=True)

# Add extra dirs for completions
$BASH_COMPLETIONS = [
    '/usr/local/etc/bash_completion',
]

# Load all the xsh files into the shell
for f in g`$DOTFILES/*/*.xsh`:
    source @(f)

# Keeping secrets in ~/.localrc
if p'~/.localrc'.exists():
    source @(p'~/.localrc')

# Make JSON parsable... a bit hacky, but super convenient to paste JSON in the shell
builtins.true = True
builtins.false = False
builtins.null = None
