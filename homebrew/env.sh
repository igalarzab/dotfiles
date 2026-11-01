# Keep an existing installation, or find Homebrew at its platform default.
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv bash)"
elif [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv bash)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv bash)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
fi

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
