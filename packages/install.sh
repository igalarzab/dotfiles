#!/bin/bash

# Choose what package managers to use depending on the OS
HOMEBREW=0
GEM=0
NPM=0


if [[ "$OSTYPE" == "darwin"* ]]; then
    HOMEBREW=1
    GEM=1
    NPM=1
else
    echo "OS not supported"
    exit 1
fi


if [[ "$HOMEBREW" == "1" ]]; then
    for app in $(cat homebrew.txt); do
        brew install $app
    done

    for app in $(cat cask.txt); do
        brew cask install $app
    done
fi

if [[ "$GEM" == "1" ]]; then
    for app in $(cat gem.txt); do
        sudo gem install $app
    done
fi

if [[ "$NPM" == "1" ]]; then
    for app in $(cat npm.txt); do
        npm install -g $app
    done
fi
