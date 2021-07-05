# Language
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

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
fish_add_path /usr/local/sbin
fish_add_path $DOTFILES/bin
