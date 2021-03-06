#!/bin/sh
set -e

cmde() {
    which "$1" > /dev/null
}

if [ $# -lt 1 ]; then
    exit 0
fi

if cmde apk; then
    apk add --no-cache $@
elif cmde lpkg; then
    echo y | lpkg install $@
else
    echo "No compatible package manager found"
    exit 1
fi
