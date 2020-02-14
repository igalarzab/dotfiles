# On mac, if coreutils are installed...
if type -q gls
  #alias ls="gls --color"
end

# On mac, if coreutils are installed...
if type -q gsed
  alias sed="gsed"
end

# Add aliases to watch
alias watch="watch "

# ls aliases
alias l="ls"
alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"

# Generic aliases
alias grep="grep --color=auto"

