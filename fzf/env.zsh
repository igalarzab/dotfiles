export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -L 3 -C {}) 2> /dev/null | head -200'"

# Mainly used inside of vim/neovim
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"

if [ -f /usr/local/opt/fzf/shell/completion.zsh ]; then
	source /usr/local/opt/fzf/shell/completion.zsh
	source /usr/local/opt/fzf/shell/key-bindings.zsh
fi

bindkey '^P' fzf-file-widget
bindkey '^R' fzf-history-widget

