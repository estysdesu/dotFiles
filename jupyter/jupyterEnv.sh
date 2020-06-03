#!/usr/bin/env sh

set -e

SETUP_FILES="$DOTFILES/python/jupyter"
ENV_NAME='jupyter'

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [ -z "$(pyenv virtualenvs | grep $ENV_NAME)" ]; then
	echo "Creating $ENV_NAME Python virtual environment..."
	pyenv virtualenv "$ENV_NAME"
fi
	
pyenv activate "$ENV_NAME"
ENV_PATH="$(pyenv virtualenv-prefix)/envs/$ENV_NAME"
echo 'Installing Python packages and Jupyter extensions...'
python -m pip install -qU pip
python -m pip install -qr "$SETUP_FILES/requirements.txt"
python -m pip install -qr "$SETUP_FILES/requirements.user.txt"
source "$SETUP_FILES/postBuild" &> /dev/null
source "$SETUP_FILES/postBuild.user" &> /dev/null

echo 'Linking files...'
mkdir -p "$ENV_PATH/dev"
ln -sfn "$SETUP_FILES/requirements.txt" "$ENV_PATH/dev/"
ln -sfn "$SETUP_FILES/requirements.user.txt" "$ENV_PATH/dev/"
ln -sfn "$SETUP_FILES/postBuild" "$ENV_PATH/dev/"
ln -sfn "$SETUP_FILES/postBuild.user" "$ENV_PATH/dev/"
mkdir -p "$ENV_PATH/share/jupyter/lab/settings/"
ln -sfn "$SETUP_FILES/overrides.json" "$ENV_PATH/share/jupyter/lab/settings/"

# Install Rust kernel (https://github.com/google/evcxr/blob/master/evcxr_jupyter/README.md)
cargo install evcxr_jupyter --no-default-features
evcxr_jupyter --install && mv "$HOME/Library/Jupyter/kernels/rust" "$ENV_PATH/share/jupyter/kernels/"

# Installing Julia kernel
brew install 
julia <<< 'using Pkg; Pkg.add("IJulia")' && mv "$HOME/Library/Jupyter/kernels/julia-*" "$ENV_PATH/share/jupyter/kernels/"

