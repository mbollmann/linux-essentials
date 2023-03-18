#!/usr/bin/env fish

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if command -q pet
    echo_status "pet already installed."
    exit 0
else
    echo_status "Installing pet [via github.com/knqyf263/pet]"
    # Install prerequisites
    sudo dnf install jq
    # Find URL of prepackaged RPM
    set -l PETRPM (curl -s https://api.github.com/repos/knqyf263/pet/releases/latest | jq '.assets[] | select(.name|match("linux_amd64.rpm$")) | .browser_download_url' | tr -d \")
    if test -z "$PETRPM"
        echo_error "pet: no linux_amd64.rpm found (maybe the latest release doesn't have one?)"
    else
        sudo dnf install --assumeyes "$PETRPM"
    end
end

if not command -q pet
    echo_error "Installation of pet failed."
    exit 1
end
