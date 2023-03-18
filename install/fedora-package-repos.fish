#!/usr/bin/env fish

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

# RPM Fusion (free + nonfree)
set -l repo (dnf repolist rpmfusion-free)
if test -z "$repo"
    echo_status "Installing rpmfusion-free"
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
else
    echo_status "rpmfusion-free already installed."
end

set -l repo (dnf repolist rpmfusion-nonfree)
if test -z "$repo"
    echo_status "Installing rpmfusion-nonfree"
    sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
else
    echo_status "rpmfusion-nonfree already installed."
end
