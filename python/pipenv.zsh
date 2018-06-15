export PIPENV_SHELL_COMPAT=1
export PIPENV_SHELL_FANCY=1

_togglePipenvShell() {
  # Deactivate shell if Pipfile doesn't exit and not in a sub dir
  if [[ ! -a "$PWD/Pipfile" ]]; then
      if [[ "$PIPENV_ACTIVE" == 1 ]]; then
          if [[ "$PWD" != "$PIPFILE_DIR"* ]]; then
            exit
          fi
    fi
  fi

  # Activate the shell if Pipfile exists
  if [[ "$PIPENV_ACTIVE" != 1 ]]; then
    if [[ -a "$PWD/Pipfile" ]]; then
      export PIPFILE_DIR="$PWD"
      pipenv shell
    fi
  fi
}

function chpwd() {
    _togglePipenvShell
}

