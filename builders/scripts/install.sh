#!/bin/sh
set -e

cmde() {
    which "$1" > /dev/null
}

if cmde apk; then
    apk add --no-cache $@
elif cmde lpkg; then
    lpkg install $@
else
    echo "No compatible package manager found"
    exit 1
fi
