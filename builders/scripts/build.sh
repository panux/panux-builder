#!/bin/sh
set -e

# Validate arguments
if [ $# -lt 2 ]; then
    echo Missing arguments
    exit 1
fi
if [ ! -e $1 ]; then
    echo Source file "$1" does not exist
    exit 2
fi
if [ ! -d $2 ]; then
    if [ -e $2 ]; then
        echo Destination directory "$2" is not a directory
        exit 3
    fi
    echo Destination directory "$2" does not exist
    exit 2
fi

BD=$(mktemp -d)

tar -xf $1 -C $BD

if ! make -j6 -C $BD; then
    echo "Build failed. Attempting to upload to transfer.sh"
    /scripts/install.sh curl
    echo "Tarring build. . . "
    tar -cf build.tar.gz -C $BD .
    echo "Uploading. . . "
    curl --upload-file build.tar.gz https://transfer.sh/build.tar.gz
    exit 4
fi

cp $BD/tars/*.tar.gz $2
