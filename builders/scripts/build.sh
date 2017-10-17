#!/bin/sh
set -e

# Validate arguments
if [ $# -lt 3 ]; then
    echo Missing arguments
    exit 1
fi
if [ ! -d $1 ]; then
    if [ -e $1 ]; then
        echo Source directory "$1" is not a directory
        exit 3
    fi
    echo Source directory "$1" does not exist
    exit 2
fi
if [ ! -e $2 ]; then
    echo Makefile "$2" does not exist
    exit 2
fi
if [ ! -d $3 ]; then
    if [ -e $3 ]; then
        echo Destination directory "$3" is not a directory
        exit 3
    fi
    echo Destination directory "$3" does not exist
    exit 2
fi

BD=$(mktemp -d)

cp -r $1 $BD/src
cp $2 $BD/Makefile

if ! make -j6 -C $BD; then
    echo "Build failed. Attempting to upload to transfer.sh"
    /scripts/install.sh curl
    echo "Tarring build. . . "
    tar -cf build.tar.gz -C $BD .
    echo "Uploading. . . "
    curl --upload-file build.tar.gz https://transfer.sh/build.tar.gz
    exit 4
fi

cp $BD/tars/*.tar.gz $3
