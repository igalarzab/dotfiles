# 🏠 igalarzab dotfiles

Your dotfiles are how you personalize your system. These are mine.

This repository contains configuration files and automation scripts for setting up a development
environment on macOS and Linux with modern command-line tools, applications, and personalized settings.

## 🚀 Quick Start

Just run the following commands in your system:

```sh
git clone https://github.com/igalarzab/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
./install
```

Day to day, `./install links` is enough — symlinks only, offline, about a
second. The bare `./install` also does packages, runtimes and system defaults,
which is what a new machine or a changed Brewfile needs. Add `--dry-run` to
either, or see `./install --help`.

### Ubuntu / Pandora

The same `./install` command installs shared CLI tools through Homebrew on Linux.
Install Homebrew's [Ubuntu prerequisites](https://docs.brew.sh/Homebrew-on-Linux) first:

```sh
sudo apt-get install build-essential procps curl file git
```

macOS defaults, desktop casks, and the OrbStack/Keychain Docker
configuration are applied only on macOS. Linux Docker configuration stays local;
install Docker and desktop applications separately if needed. Ghostty uses the
system login shell rather than a platform-specific xonsh path.

Before installing on an existing machine, run `./install links --dry-run`.
Dotbot refuses to overwrite real files or directories. On Pandora, `~/.ssh` and
`~/.config/mise` already exist: back them up, merge the settings you need, and
move the original directories aside before linking. Preserve SSH keys,
`known_hosts`, and mise settings; do not use force to discard them. Keep this
checkout at a permanent location because the links point into it.

Provide Git identity and SSH signing settings in `~/.config/git/config-local`,
as described below, before making signed commits. `./install` also registers
xonsh and sets it as the login shell; sudo or a password prompt may be needed.

## 📦 What's Included

### Development Tools
- **Shell**: `xonsh` as the primary interactive shell, with parallel Bash/zsh configuration
- **Editor**: Neovim with optimized settings
- **Terminal**: iTerm2 configurations
- **Version Control**: Git with helpful aliases and configurations
- **Package Management**: Homebrew bundle with essential tools

### Command Line Utilities
- Modern replacements: `bat`, `fd`, `fzf`, `ripgrep`, `delta`, `zoxide`
- Development tools: `gh`, `jq`, `mise`, `uv`, `llm`
- System utilities: `coreutils`, `gnu-sed`, `watch`, `tree`, `pstree`

### Applications
Automatically installs productivity and development applications via Homebrew Cask including:
- **Browsers**: Arc
- **Development**: Visual Studio Code, ChatGPT, Claude
- **Productivity**: Raycast, Rectangle Pro, Fantastical, Notion
- **Utilities**: 1Password, AppCleaner, The Unarchiver, Cryptomator

## ⚙️ How It Works

Setup is managed by [dotbot](https://github.com/anishathalye/dotbot), pinned as
a submodule. Everything setup-related lives in `dotbot/`:

- `dotbot/dotbot/` — the vendored tool, pinned to a tagged release.
- `dotbot/links.conf.yaml` — symlinks only. Fast and offline.
- `dotbot/bootstrap.conf.yaml` — Homebrew, `mise`, macOS defaults, agent skills.
- `dotbot/links.macos.conf.yaml` — macOS-only Docker links.
- `dotbot/hosts/<hostname>.conf.yaml` — optional, picked up automatically on that machine.

The `regexlink` plugin in `dotbot/plugins/regexlink.py` creates symlinks by
pattern rather than listing them one by one:

- `*.symlink` → `~/.*` (hidden files in home directory)
- `*.configsymlink` → `~/.config/*` (XDG config directory)
- `*.codexsymlink` → `~/.codex/*`

Adding a config means giving the file or directory one of those suffixes. No
config edit needed. Docker is an explicit macOS-only exception.

Note that dotbot only reports changes and problems, so a run with nothing to do
is quiet by design. Pass `-v` to see every link it checked.

## 📁 Directory Structure

Each topic area has its own directory with relevant configurations:

- **aws/**: AWS CLI configurations
- **bin/**: Custom scripts added to `$PATH`
- **git/**: Git configuration and aliases
- **gnupg/**: GPG settings for commit signing
- **kubernetes/**: kubectl and k8s tool configurations
- **macos/**: macOS-specific settings
- **mise/**: Runtime version management
- **vim/**: Neovim configuration
- **xonsh/**: Shell configuration and custom functions
- **zsh/**: zsh startup used by interactive shells and Codex

App-specific shell configuration stays with the app and is loaded by extension:

- `env.sh` and `init.sh`: shared by xonsh, zsh, and Bash
- `*.xsh`: xonsh-specific setup
- `*.zsh`: zsh-specific setup
- `*.bash`: Bash-specific setup

Xonsh and zsh load this configuration automatically. The shared files are ready
for Bash too, but Bash does not have its own startup loader yet.

## 🎨 Customization

### Adding Your Own Configurations

Create local configuration files that won't be tracked by git:

**Git Configuration** (`~/.config/git/config-local`):
```ini
[user]
    name         = Your Name
    email        = your.email@example.com
    signingkey   = your-gpg-key-id
[github]
    user         = your-github-username
```

**SSH Configuration** (`~/.ssh/config-local`):
```
# Add your custom SSH configurations here
```

### Extending the Setup

1. **Add new topic directories**: Create a new directory (e.g., `python/`) and add configuration files
2. **Install additional packages**: Edit `packages/Brewfile` to add more Homebrew formulas or casks
3. **Modify automation**: Add steps to `dotbot/bootstrap.conf.yaml`, or to `dotbot/hosts/<hostname>.conf.yaml` for one machine only

## 📋 Requirements

- macOS or Linux (Ubuntu on Pandora)
- Python 3 to run the vendored dotbot installer
- 🌐 Internet connection for downloading packages
- 🔑 Administrative privileges for some installations

## 🔧 Troubleshooting

- Run `./install` again to retry failed installations, or `./install --dry-run` to inspect the plan without changing anything
- Check `packages/Brewfile` if specific packages fail to install
- Verify symlinks with `ls -la ~/.*` and `ls -la ~/.config/`

---

**Note**: Fork this repository and customize it for your own needs. These configurations are
tailored to my personal workflow and preferences.
