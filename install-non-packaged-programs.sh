#!/bin/bash

# This script collects programs that are not supplied by a Fedora-compatible
# package repo, but instead installed via some language's package manager, such
# as npm or cargo.

#if [[ $# -lt 1 ]]; then
#    echo "Usage: install-pkg-fedora.sh <package-list>..."
#    echo "  <package-list> is a file containing one package name per line"
#    exit 1
#fi

if [ $(id -u) = 0 ]; then
    echo "This script shouldn't be run as root."
    exit 1
fi

if which npm >/dev/null; then
    # Install global packages in user directory
    if ! [ -d ~/.npm-global ]; then
        mkdir ~/.npm-global
        npm config set prefix '~/.npm-global'
        export NPM_CONFIG_PREFIX=~/.npm-global
    fi

    # Joplin
    if ! which joplin >/dev/null; then
        echo ">>> Installing Joplin [via npm]"
        npm install -g joplin
    fi

else
    echo "!!! npm isn't installed; skipping installation of npm packages."
fi
