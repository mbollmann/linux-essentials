#!/bin/bash

## This script attempts to install the complete Fish shell environment.

echo_status() {
    echo -e "\033[1m\033[32m***\033[94m" $* "\033[0m"
}

echo_error() {
    echo -e "\033[1m\033[31m!!!\033[31m" $* "\033[0m"
}

if [ $(id -u) = 0 ]; then
    echo_error "This script shouldn't be run as root."
    exit 1
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    --force)
      FORCE_INSTALL=YES
      shift # past argument
      ;;
    -h|--help)
      SHOW_HELP=YES
      shift # past argument
      ;;
    -*|--*)
      echo_error "Unknown option $1"
      exit 1
      ;;
    *)
      SHOW_HELP=YES
      shift # past argument
      ;;
  esac
done

if [[ -n "${SHOW_HELP}" ]]; then
    echo "Usage: bootstrap-fish.sh [--force]"
    echo ""
    echo "This script will install a complete Fish shell environment."
    echo "Use the --force option to run this script even if Fish is already"
    echo "installed."
    exit 0
fi

if which fish >/dev/null 2>&1 && [[ -z "$FORCE_INSTALL" ]]; then
   echo_status "fish is already installed."
   echo ""
   echo "Note: use --force if you want to run this script anyway."
   exit 0
fi

echo_status "Installing fish"
sudo dnf install --assumeyes fish

if ! which fish >/dev/null 2>&1 ; then
    echo_error "Installation of fish failed."
    exit 1
fi

echo_status "Syncing fish configuration"
mkdir -p ~/.config/fish
rsync -au --exclude-from=.sync-exclude dot-files/.config/fish/ ~/.config/fish/

echo_status "Installing fisher"
fish --no-config -c "curl -sL https://git.io/fisher | source"

echo_status "Installing plugins via fisher"
fish -c "fisher update"
fish install/starship.fish

echo_status "Setting" $(which fish) "as the default shell for" $USER
chsh --shell $(which fish) $USER
