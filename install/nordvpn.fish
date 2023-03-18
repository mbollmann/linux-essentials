#!/usr/bin/env fish

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if command -q nordvpn
    echo_status "nordvpn already installed."
    exit 0
else
    echo_status "Installing nordvpn [via downloads.nordcdn.com/apps/linux/install.sh]"
    curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh | sh
end

if not command -q nordvpn
    echo_error "Installation of nordvpn failed."
    exit 1
end
