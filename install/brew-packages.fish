#!/usr/bin/env fish

################################################################################
## This script installs packages available via Homebrew.  It will install     ##
## Homebrew first if necessary.                                               ##
##                                                                            ##
## List of packages that will be installed:                                   ##
set -l MY_HOMEBREW_PACKAGES autorestic curlie gocryptfs grex gum timg typst yazi yt-dlp yq
################################################################################

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

# brew often fails with "Too many open files"
ulimit -Sn 32768

if not command -q brew
    echo_status "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if test -f /home/linuxbrew/.linuxbrew/bin/brew
        eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    end
    if not command -q brew
        echo_error "Installation of Homebrew failed and/or environment variables not set."
        exit 1
    end
else
    brew upgrade
end

for pkg in $MY_HOMEBREW_PACKAGES
    if brew list $pkg &>/dev/null
        echo_status $pkg already installed.
    else
        echo_status Installing $pkg "[via brew]"
        brew install $pkg
    end
end

# This messes with FUSE mounts if it gets installed
brew unlink libfuse
