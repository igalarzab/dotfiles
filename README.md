# 🏠 igalarzab dotfiles

Your dotfiles are how you personalize your system. These are mine.

This repository contains configuration files and automation scripts for setting up a development environment on macOS with modern command-line tools, applications, and personalized settings.

## 🚀 Quick Start

Just run the following commands in your system:

```sh
git clone https://github.com/igalarzab/dotfiles ~/.config/dotfiles
cd ~/.config/dotfiles
./sidot run
```

## 📦 What's Included

### Development Tools
- **Shell**: `xonsh` with custom configurations
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

The setup is managed by `sidot` (SImple DOTfiles Script), a custom Python tool that:

1. **Installs Homebrew** and all packages defined in `packages/Brewfile`
2. **Symlinks configuration files** using pattern-based rules:
   - `*.symlink` files → `~/.*` (hidden files in home directory)
   - `*.configsymlink` files → `~/.config/*` (XDG config directory)
3. **Sets up development tools** via `mise` (version manager)

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
3. **Modify automation**: Update `sidot.toml` to add custom setup steps

## 📋 Requirements

- 🍎 macOS (tested on recent versions)
- 🌐 Internet connection for downloading packages
- 🔑 Administrative privileges for some installations

## 🔧 Troubleshooting

- Run `./sidot run` again to retry failed installations
- Check `packages/Brewfile` if specific packages fail to install
- Verify symlinks with `ls -la ~/.*` and `ls -la ~/.config/`

---

**Note**: Fork this repository and customize it for your own needs. These configurations are tailored to my personal workflow and preferences.
