#! /bin/sh
#
# This is the darwin sh file cherry-picked from @hjuutilainen/dotfiles,
# @mathiasbynens/dotfiles and interweb scavenging. I usually run this
# on every fresh OS X installation.
#

# Get password upfront and extend timeout for a while.
sudo -v

# Update out `sudo` time stamp until we are done. Runs in the background →&
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

echo "Show scrollbars only when scrolling"
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

echo "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Remove duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -kill -r -domain local -domain system -domain user

echo "Disable the crash reporter"
defaults write com.apple.CrashReporter DialogType -string "none"

echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Disable Notification Center and remove the menu bar icon"
launchctl unload \
  -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist \
  2> /dev/null


echo "Disable local Time Machine snapshots"
sudo tmutil disablelocal

echo "Disable the sudden motion sensor as it's not useful for SSDs"
sudo pmset -a sms 0

echo "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "Set HOME as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Show File Extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Hide directories in $HOME"
chflags hidden ~/VirtualBox ~/Library ~/Dropbox

echo "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

echo "Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "Don't show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0

echo "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0

echo "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo "Always open everything in Finder's list view."
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Kill affected applications
for app in Finder Dock Mail Safari iTunes iCal Address\ Book SystemUIServer; do killall "$app" > /dev/null 2>&1; done
echo "Done. Note that some of these changes require a logout/restart to take effect."
