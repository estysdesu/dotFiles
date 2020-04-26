#!/usr/bin/env sh

set -e

HERE="${DOTFILES}/python/jupyterEnv" # use $(pwd) instead?
ENVS_PATH="${HOME}/pythonEnvs"
JUPYTER_ENV="${ENVS_PATH}/jupyter"

if [ ! -d ${JUPYTER_ENV} ]; then
	echo "Creating Python virtual environment at ${JUPYTER_ENV}"
	mkdir -p "${JUPYTER_ENV}"
	python3 -m venv "${JUPYTER_ENV}" # add conditional for if already exists
fi

envBin="${JUPYTER_ENV}/bin"
export PATH="${envBin}:${PATH}" # add env's bin before rest of path

echo 'Installing Python packages and Jupyter extensions'
python -m pip install -qU pip
python -m pip install -qr requirements.txt
python -m pip install -qr requirements.user.txt
ipython kernel install --user --name=jupyter &> /dev/null
source postBuild &> /dev/null
source postBuild.user &> /dev/null

echo 'Linking files'
mkdir -p "${JUPYTER_ENV}/dev"
ln -sfn "${HERE}/requirements.txt" "${JUPYTER_ENV}/dev/"
ln -sfn "${HERE}/requirements.user.txt" "${JUPYTER_ENV}/dev/"
ln -sfn "${HERE}/postBuild" "${JUPYTER_ENV}/dev/"
ln -sfn "${HERE}/postBuild.user" "${JUPYTER_ENV}/dev/"
mkdir -p "${JUPYTER_ENV}/share/jupyter/lab/settings/"
ln -sfn "${HERE}/overrides.json" "${JUPYTER_ENV}/share/jupyter/lab/settings/"
