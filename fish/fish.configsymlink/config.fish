# Language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Shortcut to this dotfiles
export DOTFILES=$HOME/.dotfiles

# Save secret crap inside ~/.localrc
if test -e ~/.localrc
  source ~/.localrc
end

# Source all fish files
for cfg_file in $DOTFILES/*/*.fish
    source $cfg_file
end

# Path
set -gx PATH $PATH $DOTFILES/bin
