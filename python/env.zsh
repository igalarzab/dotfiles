if (( $+commands[pyenv] ))
then
    export PYENV_ROOT=~/.pyenv/
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if (( $+commands[pipenv] ))
then
    export PIPENV_SHELL_COMPAT=1
    export PIPENV_SHELL_FANCY=1
fi
