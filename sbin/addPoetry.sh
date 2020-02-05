#!/usr/bin/env sh

set -e 

if [ $(id -u) -eq 0 ]; then
	echo "This script cannot be run as root" >&2
	exit 1
fi

echo "Python2's subprocess32 module may not be present. Workaround below:\n\thttps://github.com/python-poetry/poetry/issues/1257"
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
