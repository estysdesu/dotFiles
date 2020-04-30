#!/usr/bin/env sh

set -e

HERE="$DOTFILES/python/jupyterEnv"
ENVS_PATH="$HOME/.python/venvs"
JUPYTER_ENV="$ENVS_PATH/jupyter"

if [ ! -d $JUPYTER_ENV ]; then
	echo "Creating Python virtual environment at $JUPYTER_ENV..."
	mkdir -p "$JUPYTER_ENV"
	python3 -m venv "$JUPYTER_ENV" # add conditional for if already exists
fi

envBin="$JUPYTER_ENV/bin"
export PATH="$envBin:${PATH}" # add env's bin before rest of path

echo 'Installing Python packages and Jupyter extensions...'
python -m pip install -qU pip
python -m pip install -qr "$HERE/requirements.txt"
python -m pip install -qr "$HERE/requirements.user.txt"
ipython kernelspec install-self &> /dev/null
# ipython kernelspec install --user --name=jupyter &> /dev/null
# python -m ipykernel install --user --name=jupyter &> /dev/null
source "$HERE/postBuild" &> /dev/null
source "$HERE/postBuild.user" &> /dev/null

echo 'Linking files...'
mkdir -p "$JUPYTER_ENV/dev"
ln -sfn "$HERE/requirements.txt" "$JUPYTER_ENV/dev/"
ln -sfn "$HERE/requirements.user.txt" "$JUPYTER_ENV/dev/"
ln -sfn "$HERE/postBuild" "$JUPYTER_ENV/dev/"
ln -sfn "$HERE/postBuild.user" "$JUPYTER_ENV/dev/"
mkdir -p "$JUPYTER_ENV/share/jupyter/lab/settings/"
ln -sfn "$HERE/overrides.json" "$JUPYTER_ENV/share/jupyter/lab/settings/"
