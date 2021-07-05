if type -q pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    set -x fish_user_paths $PYENV_ROOT/bin $fish_user_paths

    status is-login; and pyenv init --path | source
end
