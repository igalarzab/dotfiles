#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
export PATH="$HOME/.local/bin:$PATH"

case "$(uname -s)" in
  Darwin)
    ./homebrew/install.sh
    . ./homebrew/env.sh

    brew update
    brew bundle --no-upgrade --file=./packages/Brewfile
    ;;

  Linux)
    if ! command -v apt-get >/dev/null 2>&1; then
      echo "Linux setup requires an APT-based distribution" >&2
      exit 1
    fi

    sudo apt-get update

    if ! apt-cache show mise >/dev/null 2>&1; then
      sudo apt-get install -y --no-install-recommends extrepo
      sudo extrepo enable mise
      sudo apt-get update
    fi

    xargs -r -a packages/Aptfile sudo apt-get install -y --no-install-recommends

    mkdir -p "$HOME/.local/bin"

    if ! command -v bat >/dev/null 2>&1; then
      ln -s "$(command -v batcat)" "$HOME/.local/bin/bat"
    fi

    if ! command -v fd >/dev/null 2>&1; then
      ln -s "$(command -v fdfind)" "$HOME/.local/bin/fd"
    fi
    ;;

  *)
    echo "Unsupported platform: $(uname -s)" >&2
    exit 1
    ;;
esac
