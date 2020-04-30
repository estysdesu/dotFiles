#/usr/bin/env sh

set -e
set -v

##### SETUP #####
dotFilesGitURL='https://github.com/estysdesu/dotFiles.git'
dotFilesGitURLRaw='https://raw.githubusercontent.com/estysdesu/dotFiles'
dotFilesLocalURL="$HOME/dotFiles"
sudo -v

echo "Starting bootstrapping..."
##### DISABLE RO ROOT ("/") #####
read -p "Please disable SIP first by booting into recovery and running \`csrutil disable\`. If you've done this, please press [Enter]."
sudo spctl --master-disable # disable gatekeeper
sudo mount -uw / # makes root folder writeable
sudo killall Finder # makes root folder writeable

##### SYS SETTINGS #####
echo "Configuring macOS system settings..."
sh $(curl $dotFilesGitURLRaw/mac/_bootstrap/defaults.sh) && true

##### XCODE CLI #####
xcode-select -p &> /dev/null
if [ $? -eq 2 ]; then
	echo "Installing XCode CLI tools..."
	xcode-select --install; sleep 3 # typically takes a few seconds for the dialog to open
fi

##### HOMEBREW #####
if [ -z $(which brew) ]; then
    echo "Installing homebrew..."
    $(which bash) -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

##### DOTFILES #####
if [ ! -d $dotFilesLocalURL ]; then
    brew install git
    echo "Cloning dotFiles from: ($dotFilesGitURL)..."
    git clone "$dotFilesGitURL" "$dotFilesLocalURL"
fi
cd $dotFilesLocalURL && make sym-refresh
source $dotFilesLocalURL/env # brings in system environment

##### BREW BUNDLE #####
brew bundle  &> /dev/null && true # calling bundle installs bundle, can't be installed with traditional `brew install`
brew install cask
brew install mas
read -p "Please open the Apple Store and sign-in manually, then return here and press [Enter] key to continue..." # sign-in to Apple Store # mas signin --dialog tylerscottestes@gmail.com # (depped)
echo "Installing packages..."
cd $DOTFILES && make brew-install # brew bundle --file="$dotFilesLocalURL/homebrew/Brewfile"

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

##### VSCODE #####
# TODO: install extensions

##### NVIM PLUGGED #####

##### TMUX TPM #####

##### CLEANING #####
echo "Cleaning up..."
brew cleanup
if [ -e "~/Library/Application Support/Dock/*.db" ]; then
    rm "~/Library/Application Support/Dock/*.db" # reset Launchpad
fi

echo "Bootstrapping complete"
