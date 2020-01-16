#!/usr/bin/env sh

cat extensions.txt | while read extension; do
   code --install-extension ${extension}
done
