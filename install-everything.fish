#!/usr/bin/env fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

for packages in (dirname (status --current-filename))/pkg-fedora/*.txt
    sudo dnf install (cat $packages)
end

for script in (dirname (status --current-filename))/install/*.fish
    if string match --regex "^_" --quiet (basename $script)
        continue
    end

    # If script is not executable, we don't want to install it by default
    if test -x "$script"
        fish $script
    end
end

bash (dirname (status --current-filename))/sync-dotfiles.sh

if test -f ".config/systemd/user/emacs-256color.service"
    systemctl --user enable emacs-256color
end
