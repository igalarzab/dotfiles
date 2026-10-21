case $- in
  *i*)
    if command -v fzf >/dev/null 2>&1; then
      if command -v atuin >/dev/null 2>&1; then
        FZF_CTRL_R_COMMAND= eval "$(fzf --zsh)"
      else
        eval "$(fzf --zsh)"
      fi
    fi
    ;;
esac
