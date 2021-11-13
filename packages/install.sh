#!/bin/bash

set -e

# Choose what package managers to use depending on the OS
APK=0
HOMEBREW=0
GEM=0
NPM=0
PIP=0

# Other vars
PYTHON_VERSION=3.10.0


if [[ "$OSTYPE" == "darwin"* ]]; then
    APK=0
    HOMEBREW=1
    GEM=1
    NPM=1
    PIP=1
elif [[ "$OSTYPE" == "linux-musl" ]]; then
    APK=1
    HOMEBREW=0
    GEM=0
    NPM=1
    PIP=1
else
    echo "OS not supported"
    exit 1
fi

if [[ "$APK" == "1" ]]; then
    for app in $(cat apk.txt); do
	echo "Installing $app..."
        apk add $app
    done
fi


if [[ "$HOMEBREW" == "1" ]]; then
    # Install homebrew first
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    for app in $(cat homebrew.txt); do
        brew install $app
    done

    for app in $(cat cask.txt); do
        brew install $app
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

    for app in $(cat pip.txt); do
        pip install $app
    done

    pyenv virtualenv $PYTHON_VERSION neovim

fi

 echo 'Remember to install fisher and packer.nvim'
