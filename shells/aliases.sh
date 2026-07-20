alias ..='cd ..'
alias dot='cd "$DOTFILES"'

alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias grep='grep --color=auto'

if command -v gsed >/dev/null 2>&1; then
  alias sed='gsed'
fi

if command -v gfind >/dev/null 2>&1; then
  alias find='gfind'
fi

if command -v bat >/dev/null 2>&1; then
  export BAT_THEME='OneHalfDark'
  alias cat='bat'
fi
