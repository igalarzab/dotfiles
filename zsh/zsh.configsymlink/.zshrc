# Avoid loading the configuration twice when Codex sources this file from .zshenv.
if [[ -n "${DOTFILES_ZSH_LOADED:-}" ]]; then
  return 0
fi

typeset -g DOTFILES_ZSH_LOADED=1

# Resolve the dotfiles repository from this file's real path.
typeset dotfiles_zshrc_path="${(%):-%N}"
export DOTFILES="${DOTFILES:-${dotfiles_zshrc_path:A:h:h:h}}"
unset dotfiles_zshrc_path

# Include hidden files in glob expansions.
setopt GLOB_DOTS

# Keep zsh's mutable state and cache in the standard XDG directories.
typeset zsh_state_home="${XDG_STATE_HOME:-$HOME/.local/state}"
typeset zsh_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p "$zsh_state_home/zsh" "$zsh_cache_home/zsh"

# Store persistent history without consecutive duplicate commands.
HISTFILE="$zsh_state_home/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS

# Enable vi keybindings and initialize command completion.
bindkey -v
autoload -Uz compinit
compinit -d "$zsh_cache_home/zsh/zcompdump"

unset zsh_state_home zsh_cache_home

# Load environment variables shared by all shells.
for dotfiles_file in "$DOTFILES"/*/env.sh(N); do
  source "$dotfiles_file"
done

# Load setup shared by all shells.
for dotfiles_file in "$DOTFILES"/*/init.sh(N); do
  source "$dotfiles_file"
done

# Load zsh-specific application setup.
for dotfiles_file in "$DOTFILES"/*/init.zsh(N); do
  source "$dotfiles_file"
done

# Load zsh-specific shell configuration such as the prompt.
for dotfiles_file in "$ZDOTDIR"/rc.d/*.zsh(N); do
  source "$dotfiles_file"
done

# Load machine-local configuration that is not tracked in dotfiles.
if [[ -r "$HOME/.config/local.sh" ]]; then
  source "$HOME/.config/local.sh"
fi

unset dotfiles_file
