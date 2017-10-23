#!/bin/sh

fail() {
    echo $1
    exit 1
}


if [ ! -e /var/run/docker.sock ]; then
    fail "Docker socket missing. Build will not work."
fi

echo "Starting build!"
echo "Building docker container to build builder"
chmod 700 build.sh || fail "Failed to set permissions on build.sh"
docker build -f Dockerfile.compile -t panux/builderbuilder . || fail "Failed to build docker container to run build in"
echo "Building 32-bit"
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock panux/builderbuilder x86 || fail "Failed to build x86 images"
echo "Building 64-bit"
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock panux/builderbuilder x86_64 || fail "Failed to build x86_64 images"
echo "Done!"
