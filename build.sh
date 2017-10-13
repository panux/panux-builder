#!/bin/sh

if [ ! -e /var/run/docker.sock ]; then
    echo Docker socket missing. Build will not work.
    exit 1
fi
if [ -z "$1" ]; then
    echo No arch specified.
    exit 2
fi
export ARCH=$1
export BASES=$PWD/bases

make
