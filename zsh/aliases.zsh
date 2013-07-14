# On mac, if coreutils are installed...
if (( $+commands[gls] ))
then
  alias ls="gls --color=tty"
fi

# On mac, if coreutils are installed...
if (( $+commands[gsed] ))
then
  alias sed="gsed"
fi

# ls aliases
alias l="ls"
alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"

# MacVIM
if [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]
then
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
fi

# Generic aliases
alias grep="grep --color=auto"
alias reload='. ~/.zshrc'

# cd into Development folder
alias d="cd $COMPANY"
alias s="cd $PROJECTS"

# Fucking auto-complete :D
alias knife="nocorrect knife"
