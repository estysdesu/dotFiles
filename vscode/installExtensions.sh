#!/usr/bin/env sh

cat extensions.txt | while read extension || [[ -n $extension ]];
do
   code --install-extension ${extension}
done
