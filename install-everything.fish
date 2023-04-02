#!/usr/bin/env fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

# Install dnf packages
for packages in (dirname (status --current-filename))/pkg-fedora/*.txt
    # Don't use --assumeyes so we can decide whether to install a particular
    # collection of packages or not
    sudo dnf install (cat $packages)
end

# Install other software
for script in (dirname (status --current-filename))/install/*.fish
    # If script is not executable, we don't want to install it by default
    if test -x "$script"
        fish $script
    end
end

# Sync all dot-files
bash (dirname (status --current-filename))/sync-dotfiles.sh

# Enable custom systemd services
if test -f ".config/systemd/user/emacs-256color.service"
    systemctl --user start emacs-256color ; and systemctl --user enable emacs-256color
end
