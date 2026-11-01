#!/usr/bin/env bash
set -euo pipefail

XONSH_PATH=$(command -v xonsh)
USER_NAME=$(id -un)

if ! grep -Fxq "$XONSH_PATH" /etc/shells; then
    echo "$XONSH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

if [ "$(uname -s)" = Linux ]; then
    if [ "$(getent passwd "$USER_NAME" | cut -d: -f7)" != "$XONSH_PATH" ]; then
        sudo chsh -s "$XONSH_PATH" "$USER_NAME"
    fi
elif [ "$(dscl . -read "/Users/$USER_NAME" UserShell | cut -d' ' -f2)" != "$XONSH_PATH" ]; then
    chsh -s "$XONSH_PATH"
fi
