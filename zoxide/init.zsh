case $- in
  *i*)
    if command -v zoxide >/dev/null 2>&1; then
      eval "$(zoxide init --cmd j zsh)"
    fi
    ;;
esac
