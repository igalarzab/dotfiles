if (( $+commands[stern] )); then
  source <(stern --completion=zsh)
fi

# Set the iterm2 badge
if (( $+commands[kubectl] )); then
    function iterm2_print_user_vars() {
        iterm2_set_user_var kubeContext $(kubectl config current-context)
    }
fi
