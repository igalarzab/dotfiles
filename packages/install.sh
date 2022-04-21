#!/bin/bash

set -e

# Choose what package managers to use depending on the OS
HOMEBREW=0
GEM=0
NPM=0
PIP=0

# Other vars
PYTHON_VERSION=3.10.4


if [[ "$OSTYPE" == "darwin"* ]]; then
    HOMEBREW=1
    GEM=1
    NPM=1
    PIP=1
else
    echo "OS not supported"
    exit 1
fi

if [[ "$HOMEBREW" == "1" ]]; then
    # Install homebrew first
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    for app in $(cat homebrew.txt); do
        brew install $app
    done

    for app in $(cat cask.txt); do
        brew install --cask $app
    done

    sudo bash -c 'echo /usr/local/bin/fish >> /etc/shells'
    chsh -s /usr/local/bin/fish
fi

if [[ "$GEM" == "1" ]]; then
    for app in $(cat gem.txt); do
        if [ "$EUID" -ne 0 ]; then
	    sudo gem install $app;
	else
	    gem install $app;
	fi
    done
fi

if [[ "$NPM" == "1" ]]; then
    for app in $(cat npm.txt); do
        npm install -g $app
    done
fi

if [[ "$PIP" == "1" ]]; then
    pyenv install -s $PYTHON_VERSION
    pyenv global $PYTHON_VERSION
    pyenv virtualenv $PYTHON_VERSION neovim

    for app in $(cat pip.txt); do
        pip install $app
    done
fi

 echo 'Remember to install fisher and packer.nvim and run fish_update_completions'
