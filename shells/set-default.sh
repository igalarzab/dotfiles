#!/usr/bin/env bash
#
# Make zsh the login shell, or the shell given as the first argument:
#   ./shells/set-default.sh xonsh
#
set -euo pipefail

SHELL_NAME="${1:-zsh}"
USER_NAME=$(id -un)

if ! SHELL_PATH=$(command -v "$SHELL_NAME"); then
    echo "$SHELL_NAME is not installed" >&2
    exit 1
fi

if ! grep -Fxq "$SHELL_PATH" /etc/shells; then
    echo "$SHELL_PATH" | sudo tee -a /etc/shells > /dev/null
fi

if [ "$(uname -s)" = Linux ]; then
    if [ "$(getent passwd "$USER_NAME" | cut -d: -f7)" != "$SHELL_PATH" ]; then
        sudo chsh -s "$SHELL_PATH" "$USER_NAME"
    fi
elif [ "$(dscl . -read "/Users/$USER_NAME" UserShell | cut -d' ' -f2)" != "$SHELL_PATH" ]; then
    chsh -s "$SHELL_PATH"
fi
