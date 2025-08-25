#!/bin/bash

set -e

XONSH_PATH=$(command -v xonsh)

if [[ -z $(grep xonsh /etc/shells) && -x "$XONSH_PATH" ]]; then
    echo "Setting xonsh as the default shell..."

    echo "$XONSH_PATH" | sudo tee -a /etc/shells > /dev/null
    chsh -s "$XONSH_PATH"
fi