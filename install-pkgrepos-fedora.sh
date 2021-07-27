#!/bin/bash

if ! [ -f /etc/fedora-release ]; then
    echo "This doesn't appear to be a Fedora-based distribution."
    exit 1
fi

if ! [ $(id -u) = 0 ]; then
    echo "This script needs to be run as root."
    exit 1
fi

# RPM Fusion (free + nonfree)
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
