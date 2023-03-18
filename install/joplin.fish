#!/usr/bin/env fish

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if test -f ~/.joplin/Joplin.AppImage
    echo_status "Joplin already installed."
    exit 0
else
    echo_status "Installing Joplin for Desktop [via github.com/laurent22/joplin]"
    wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
end

if not test -f ~/.joplin/Joplin.AppImage
    echo_error "Installation of Joplin failed."
    exit 1
end
