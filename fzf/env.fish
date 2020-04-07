set -x FZF_DEFAULT_COMMAND "ag -g ''"
set -x FZF_DEFAULT_OPTS "--height 60% --layout=reverse --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -L 3 -C {}) 2> /dev/null | head -200'"
