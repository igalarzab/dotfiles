#!/usr/bin/env bash
set -euo pipefail

XONSH_PATH=$(command -v xonsh)

if ! grep -Fxq "$XONSH_PATH" /etc/shells; then
    echo "$XONSH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

if [ "$(uname -s)" = Linux ]; then
    sudo chsh -s "$XONSH_PATH" "$(id -un)"
else
    chsh -s "$XONSH_PATH"
fi
