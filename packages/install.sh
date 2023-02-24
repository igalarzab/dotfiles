#!/bin/bash

set -e

# Choose what package managers to use depending on the OS
ASDF=0
HOMEBREW=0
GEM=0
NPM=0
PIP=0

if [[ "$OSTYPE" == "darwin"* ]]; then
    ASDF=1
    HOMEBREW=1
    GEM=1
    NPM=1
    PIP=1
else
    echo "OS not supported"
    exit 1
fi

# Install homebrew packages
if [[ "$HOMEBREW" == "1" ]]; then
    echo "Installing homebrew packages..."

    if ! [ -x "$(command -v brew)" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    while read app; do
        brew install $app
    done < homebrew.txt

    while read app; do
        brew install --cask $app
    done < cask.txt
fi

# Change the shell to xonsh
if [[ -z $(grep xonsh /etc/shells) && -x "$(command -v xonsh)" ]]; then
    echo "Setting xonsh as the default shell..."

    sudo bash -c 'echo /opt/homebrew/bin/xonsh >> /etc/shells'
    chsh -s /opt/homebrew/bin/xonsh
fi

# Install asdf plugins
if [[ "$ASDF" == "1" ]]; then
    echo "Enabling asdf in the shell..."
    . /opt/homebrew/opt/asdf/libexec/asdf.sh

    echo "Installing asdf plugins..."
    while read plugin; do
        p=($plugin)
	(asdf plugin-add ${p[0]} ${p[2]}) || true
        asdf install ${p[0]} ${p[1]}
        asdf global ${p[0]} ${p[1]}
        asdf shell ${p[0]} ${p[1]}
    done < asdf.txt
fi

# Install ruby packages
if [[ "$GEM" == "1" ]]; then
    echo "Installing ruby packages ($(which gem))..."

    while read app; do
        sudo gem install $app
    done < gem.txt
fi

# Install JS packages
if [[ "$NPM" == "1" ]]; then
    echo "Installing JS packages ($(which npm))..."

    while read app; do
        echo "Installing $app"
        npm install -g $app
    done < npm.txt
fi

# Install python packages
if [[ "$PIP" == "1" ]]; then
    echo "Installing python packages ($(which pip))..."

    while read app; do
        pip install --upgrade $app
    done < pip.txt
fi
