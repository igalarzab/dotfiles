for dotfiles_file in "$DOTFILES"/*/env.sh(N); do
  source "$dotfiles_file"
done
unset dotfiles_file
