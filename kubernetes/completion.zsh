if (( $+commands[stern] )); then
  source <(stern --completion=zsh)
fi

# Set the iterm2 badge
if [[ -z "${ITERM_SHELL_INTEGRATION}" ]]; then
    if (( $+commands[kubectl] )); then
        iterm2_set_user_var kubeContext $(kubectl config current-context)
    fi
fi
