e!/usr/bin/env bash
# curl -fsSL https://raw.githubusercontent.com/<user>/<repo>/<filepath> | bash

set -e # set -o errexit
set -u # set -o nounset
set -x # set -o xtrace

if [ "$(id -u)" -eq 0 ]; then
	echo 'This script cannot be run as root' >&2
	exit 1
fi

DISTRO="$(uname)"
if [ "$DISTRO" != 'Darwin' ]; then
	echo "This script is only implemented on macOS" >&2
	exit 1
fi

##### SETUP #####
PROGRAM_NAME='bootstrap'
USERNAME="$(id -un)"
DF_GIT_URL='https://github.com/estysdesu/dotFiles.git'
DF_RAW_GIT_URL='https://raw.githubusercontent.com/estysdesu/dotFiles'
DF_LOCAL_PATH="$HOME/dotFiles"

# sudo keep-alive (move timestamp)
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

##### DISABLE SIP & GATEKEEPER #####
read -p "Please disable SIP first by booting into recovery and running \`csrutil disable\`. If you've done this, please press [Enter]."
sudo spctl --master-disable # disable gatekeeper

##### INSTALL XCODE CLI #####
xcode-select -p &> /dev/null
if [ $? -eq 2 ]; then
	echo 'Installing XCode CLI tools...'
	xcode-select --install
	echo 'Please restart script after XCode installation is complete.'
fi

##### SYS SETTINGS #####
echo "Configuring macOS system settings..."

# set hostname 
HOSTNAME="TSE-MBP141-Ross"
sudo scutil --set ComputerName "$HOSTNAME"
sudo scutil --set HostName "$HOSTNAME"
sudo scutil --set LocalHostName "$HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$HOSTNAME"

##### PACKAGES #####
# install homebrew
if [ ! -x "$(which brew)" ]; then
	echo 'Installing homebrew...'
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
brew update

# clone dot files
if [ ! -d "$DF_LOCAL_PATH" ]; then
    brew install git
    echo "Cloning dotFiles from: $DF_GIT_URL..."
    git clone "$DF_GIT_URL" "$DF_LOCAL_PATH"
fi
cd "$DF_LOCAL_PATH" && make sym-refresh
source "$DF_LOCAL_PATH/env"

# install packages with brew bundle
echo 'Installing packages...'
brew install cask mas
cd "$DF_LOCAL_PATH/homebrew" && brew bundle install 

# install pyenv and python global packages
PY_VER=3.8.0
pyenv install "$PY_VER" && pyenv global "$PY_VER" && eval "$(pyenv init -)" && python -m pip install -r "$DF_LOCAL_PATH/python/requirements.system.txt"

# install pix packages
for PKG in $(cat "$DF_LOCAL_PATH/python/requirements.pipx.txt"); do
    pipx install "$PKG"
done

# install jupyter and its environment packages
# sh $dotFilesLocalURL/python/jupyterEnv/jupyterVenv.sh

# install vim-plug and plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim --headless +PlugInstall +qa

# install tpm and plugins
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

##### USER SETTINGS #####
# change shell to bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells
sudo chsh -s '/usr/local/bin/bash'

echo 'Bootstrapping complete'
