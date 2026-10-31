#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
. ./homebrew/env.sh

if ! command -v brew >/dev/null 2>&1; then
  installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /bin/bash -c "$installer"
fi
