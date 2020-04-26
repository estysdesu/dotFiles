#!/usr/bin/env sh
brew install zeromq pkg-config
cargo install evcxr_jupyter --no-default-features
evcxr_jupyter --install

mv "$HOME/Library/Jupyter/kernels/rust" "$HOME/pythonEnvs/jupyter/share/jupyter/kernels/rust"
