#!/usr/bin/env fish

### This doesn't really do anything at the moment except set a directory for
### NPM. Still preserving it for the future.

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if command -q npm
    set -l npmglobal $HOME/.npm-global
    if not test -d $npmglobal
        mkdir -p $npmglobal
        npm config set prefix "$npmglobal"
    end
    set -Ux NPM_CONFIG_PREFIX $npmglobal
end
