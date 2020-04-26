#!/usr/bin/env sh

alias code='code-insiders'
cat extensions.txt | while read extension; do
   code --install-extension ${extension}
done
