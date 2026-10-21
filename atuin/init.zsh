case $- in
  *i*)
    if command -v atuin >/dev/null 2>&1; then
      eval "$(atuin init zsh)"
    fi
    ;;
esac
