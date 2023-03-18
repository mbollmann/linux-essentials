#!/usr/bin/env fish

################################################################################
## This script installs Python packages that provide command-line tools.      ##
## (Regular packages should be installed via dnf or in virtual environments.) ##
##                                                                            ##
## List of packages that will be installed:                                   ##
set -l MY_PYTHON_PACKAGES jupyterlab virtualfish
################################################################################

argparse 'u/upgrade' -- $argv
source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if not command -q pip
    sudo dnf install --assumeyes python3-pip
end

if test -n "$_flag_upgrade"
    python -m pip install --upgrade pip
end

for pkg in $MY_PYTHON_PACKAGES
    if test -n "$_flag_upgrade"
        echo_status "Installing or upgrading" $pkg "[via pip]"
        python -m pip install --user --upgrade --quiet $pkg
    else if python -m pip show $pkg &>/dev/null
        echo_status $pkg already installed.
    else
        echo_status Installing $pkg "[via pip]"
        python -m pip install --user --quiet $pkg
    end
end
