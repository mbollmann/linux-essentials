#!/bin/bash

if ! [ -f /etc/fedora-release ]; then
    echo "This doesn't appear to be a Fedora-based distribution."
    exit 1
fi

if [[ $# -lt 1 ]]; then
    echo "Usage: install-pkg-fedora.sh <package-list>..."
    echo "  <package-list> is a file containing one package name per line"
    exit 1
fi

if ! [ $(id -u) = 0 ]; then
    echo "This script needs to be run as root."
    exit 1
fi

for var in "$@"
do
    dnf -y install $(tr '\n' ' ' < "$var")
done
