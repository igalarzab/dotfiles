export PYENV_ROOT=~/.pyenv/
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if (( $+commands[pyenv] ))
then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

