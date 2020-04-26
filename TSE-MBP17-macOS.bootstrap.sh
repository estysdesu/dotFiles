#/usr/bin/env sh

##### SETUP #####
sudo -v

echo "Starting bootstrapping..."
##### DISABLE RO ROOT ("/") #####
read -p 'Please disable SIP first by booting into recovery and running `csrutil disable`. If you've done this, please press [Enter].'
sudo spctl --master-disable # disable gatekeeper
sudo mount -uw / # makes root folder writeable
sudo killall Finder # makes root folder writeable

##### SYS SETTINGS #####
echo "Configuring macOS system settings..."
computerName="TSE-MBP17-macOS"
sudo scutil --set ComputerName "$computerName"
sudo scutil --set HostName "$computerName"
sudo scutil --set LocalHostName "$computerName"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computerName"
osascript -e 'tell application "System Preferences" to quit'
sudo systemsetup -settimezone "America/Indiana/Indianapolis"
defaults write -g AppleLanguages -array "en" "jp"
defaults write -g AppleLocale -string "en_US@currency=USD"
defaults write -g AppleMeasurementUnits -string "Inches"
defaults write -g AppleMetricUnits -bool false
defaults write 'Apple Global Domain' AppleInterfaceStyle -string 'Dark' # dark theme
defaults write com.apple.screencapture location -string "$HOME/Desktop" # save screenshots to the desktop
defaults write com.apple.screencapture type -string "png" # save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screensaver askForPassword -int 1 # require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPasswordDelay -int 0 # require password as soon as screensaver or sleep mode starts
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false # save to disk (not to iCloud) by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true # expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true # expand save panel by default
defaults write -g PMPrintingExpandedStateForPrint -bool true # expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint2 -bool true # expand print panel by default
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true # automatically quit printer app once the print jobs complete
defaults write -g com.apple.swipescrolldirection -bool false # disable “natural” scrolling
defaults write -g KeyRepeat -int 3 # set a fast keyboard repeat rate
defaults write -g InitialKeyRepeat -int 10 # set a fast keyboard repeat rate
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2 # map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true # map bottom right corner to right-click
defaults write -g com.apple.trackpad.trackpadCornerClickBehavior -int 1 # map bottom right corner to right-click
defaults write -g com.apple.trackpad.enableSecondaryClick -bool true # map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # enable tap-to-click
defaults write -g com.apple.mouse.tapBehavior -int 1 # enable tap-to-click
defaults write -g com.apple.mouse.tapBehavior -int 1 # enable tap-to-click
defaults write com.apple.finder AppleShowAllFiles -bool true # Finder: show hidden files by default
defaults write com.apple.finder ShowStatusBar -bool true # Finder: show status bar
defaults write com.apple.finder ShowPathbar -bool true # Finder: show path bar
defaults write com.apple.finder NewWindowTarget -string "PfLo" # for other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/" # set $HOME as the default location for new Finder windows
defaults write com.apple.LaunchServices LSQuarantine -bool false # disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.dock mouse-over-hilite-stack -bool true # enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true # avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true # avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true # show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true # show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true # show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true # show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.dock tilesize -int 36 # set the icon size of Dock items to 36 pixels
defaults write com.apple.dock mineffect -string "scale" # change minimize/maximize window effect
defaults write com.apple.dock minimize-to-application -bool true # minimize windows into their application’s icon
defaults write com.apple.finder QLEnableTextSelection -bool true # allow text selection in Quick Look
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true # display full POSIX path as Finder window title
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # disable the warning when changing a file extension
defaults write com.apple.finder WarnOnEmptyTrash -bool false # disable the warning before emptying the Trash
defaults write com.apple.finder EmptyTrashSecurely -bool true # empty Trash securely by default
defaults write com.apple.dock show-process-indicators -bool true # show indicator lights for open applications in the Dock
defaults write com.apple.dock autohide -bool true # automatically hide and show the Dock
defaults write com.apple.Dock autohide-delay -float 0 # remove the auto-hiding Dock delay
defaults write com.apple.dock showhidden -bool true # make Dock icons of hidden applications translucent
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true # show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor IconType -int 5 # visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor ShowCategory -int 0 # show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage" # sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortDirection -int 0 # sort Activity Monitor results by CPU usage

##### XCODE CLI #####
echo "Installing XCode CLI tools..."
xcode-select --install

##### HOMEBREW #####
if [ -z $(which brew) ]; then
    echo "Installing homebrew..."
    $(which bash) -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

##### DOTFILES #####
dotFilesGitURL='https://github.com/estysdesu/dotFiles.git'
dotFilesLocalURL="$HOME/dotFiles"
if [ -d $dotFilesLocalURL ]; then
    brew install git
    echo "Cloning dotFiles from: ($dotFilesGitURL)..."
    git clone "$dotFilesGitURL" "$dotFilesLocalURL"
    cd $dotFilesLocalURL && make sym-refresh
fi
source $HOME/.zshenv

##### BREW BUNDLE #####
brew bundle  # calling bundle installs bundle, can't be installed with traditional `brew install`
brew install cask
brew install mas
read -p "Please open the Apple Store and sign-in manually, \nthen return here and press [Enter] key to continue..." # sign-in to Apple Store # mas signin --dialog tylerscottestes@gmail.com # (depped)
echo "Installing packages..."
cd $dotFilesLocalURL && make brew-install # brew bundle --file="$dotFilesLocalURL/homebrew/Brewfile"

##### PYTHON #####
pyVersion=3.8.0
pyenv install $pyVersion && pyenv global $pyVersion && eval "$(pyenv init -)" && python -m pip install "$dotFiles/LocalURL/python/requirements.system.txt"
for pkg in $(cat "$dotFilesLocalURL/python/requirements.pipx.txt"); do
    pipx install $pkg
done
sh $dotFilesLocalURL/python/jupyterEnv/jupyterVenv.sh

##### NIX #####
curl -L https://nixos.org/nix/install | sh
sudo sh "$dotFilesLocalURL/sbin/disableRORoot/setup.sh"

##### CLEANING #####
echo "Cleaning up..."
brew cleanup
if [ -e "~/Library/Application Support/Dock/*.db" ]; then
    rm "~/Library/Application Support/Dock/*.db" # reset Launchpad
fi

echo "Bootstrapping complete"
