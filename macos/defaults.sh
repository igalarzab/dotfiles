#
# MacOS Defaults
#
# https://macos-defaults.com/
#
#

# Dock
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "tilesize" -int "64"
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "show-recents" -bool "false"

# Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "true"

# Keyboard
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"

# Screenshots
defaults write com.apple.screencapture "location" -string "~/Pictures"

# TextEdit
defaults write com.apple.TextEdit "RichText" -bool "false"
defaults write com.apple.TextEdit "SmartQuotes" -bool "false"

# TimeMachine
defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool "true"

# Clock
defaults write com.apple.menuextra.clock "DateFormat" -string "\"HH:mm\""

# Restart services
killall Dock Finder SystemUIServer TextEdit
