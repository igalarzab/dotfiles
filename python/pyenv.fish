set -x PYENV_ROOT ~/.pyenv/
set -x PYENV_VIRTUALENV_DISABLE_PROMPT 1

if type -q pyenv
    source (pyenv init - | psub)
    source (pyenv virtualenv-init - | psub)
end
