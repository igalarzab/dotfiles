if type -q pyenv
    set -x PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin

    status is-login; and pyenv init --path | source
end
