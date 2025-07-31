#!/bin/bash

set -e

# Choose what package managers to use depending on the OS
HOMEBREW=0
NPM=0

PATH=$PATH:/opt/homebrew/bin

if [[ "$OSTYPE" == "darwin"* ]]; then
    HOMEBREW=1
    NPM=1
else
    echo "OS not supported"
    exit 1
fi

# Install homebrew packages
if [[ "$HOMEBREW" == "1" ]]; then
    echo "Installing homebrew..."

    if ! [ -x "$(command -v brew)" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "Installing homebrew packages..."
    brew bundle

    echo "Installing mise packages..."
    mise install
fi

# Install JS packages
if [[ "$NPM" == "1" ]]; then
    echo "Installing JS packages ($(which npm))..."

    while read -r app; do
        echo "Installing $app"
        npm install -g $app
    done < npm.txt
fi

# Change the shell to xonsh
if [[ -z $(grep xonsh /etc/shells) && -x "$(command -v xonsh)" ]]; then
    echo "Setting xonsh as the default shell..."

    sudo bash -c 'echo /opt/homebrew/bin/xonsh >> /etc/shells'
    chsh -s /opt/homebrew/bin/xonsh
fi
