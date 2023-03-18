#!/usr/bin/env fish

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if command -q starship
    echo_status "starship already installed."
    exit 0
else
    echo_status "Installing starship [via starship.rs/install.sh]"
    curl -sS https://starship.rs/install.sh | sh
end

if not command -q starship
    echo_error "Installation of starship failed."
    exit 1
end
