#!/usr/bin/env fish

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if command -q xcape
    echo_status "xcape already installed."
    exit 0
else
    echo_status "Installing xcape [via github.com/alols/xcape]"
    # Install prerequisites
    sudo dnf install --assumeyes git gcc make pkgconfig libX11-devel libXtst-devel libXi-devel
    # Checkout git repo
    set -l CURDIR (pwd)
    set -l TMPDIR (mktemp -d)
    git clone https://github.com/alols/xcape.git $TMPDIR
    cd $TMPDIR
    sed -i 's/^PREFIX=.*/PREFIX=\/usr\/local/' Makefile
    sed -i 's/^MANDIR.*/MANDIR?=\/man\/man1/' Makefile
    make
    sudo make install
    cd $CURDIR
    rm -rf $TMPDIR
end

if not command -q xcape
    echo_error "Installation of xcape failed."
    exit 1
end
