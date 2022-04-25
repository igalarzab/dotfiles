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

    for app in $(cat homebrew.txt); do
        brew install $app
    done

    for app in $(cat cask.txt); do
        brew install --cask $app
    done
fi

# Enable asdf in the shell script
if [ -x "$(command -v asdf)" ]; then
    echo "Enabling asdf in the shell..."
    . /usr/local/opt/asdf/libexec/asdf.sh

    for plugin in $(cat xpip.txt); do
        xpip install $plugin
    done
fi

# Change the shell to xonsh
if [[ -z $(grep xonsh /etc/shells) && -x "$(command -v xonsh)" ]]; then
    echo "Setting xonsh as the default shell..."

    sudo bash -c 'echo /usr/local/bin/xonsh >> /etc/shells'
    chsh -s /usr/local/bin/xonsh
fi

# Install asdf plugins
if [[ "$ASDF" == "1" ]]; then
    echo "Installing asdf plugins..."

    for plugin in $(cat asdf.txt); do
        asdf install $plugin latest
        asdf global $plugin latest
        asdf shell $plugin latest
    done
fi

# Install ruby packages
if [[ "$GEM" == "1" ]]; then
    echo "Installing ruby packages ($(which gem))..."

    for app in $(cat gem.txt); do
        if [ "$EUID" -ne 0 ]; then
            sudo gem install $app
        else
            gem install $app
        fi
    done
fi

# Install JS packages
if [[ "$NPM" == "1" ]]; then
    echo "Installing JS packages ($(which npm))..."

    for app in $(cat npm.txt); do
        echo "Installing $app"
        npm install -g $app
    done
fi

# Install python packages
if [[ "$PIP" == "1" ]]; then
    echo "Installing python packages ($(which pip))..."

    for app in $(cat pip.txt); do
        pip install $app
    done
fi
