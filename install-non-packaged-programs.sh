#!/bin/bash

# This script collects programs that are not supplied by a Fedora-compatible
# package repo, but instead installed via some language's package manager, such
# as npm or cargo.

echo_status() {
    echo -e "\033[1m\033[32m***\033[94m" $* "\033[0m"
}

echo_error() {
    echo -e "\033[1m\033[31m!!!\033[31m" $* "\033[0m"
}

if [[ $# -gt 0 ]]; then
    echo "This script will check for/install the following:"
    echo ""
#    echo "   - Joplin"
    echo "   - brew (Homebrew)"
    echo "   - grex"
    echo "   - jupyter-lab"
    echo "   - pet"
    echo "   - starship"
    echo "   - timg"
    echo "   - virtualfish"
    echo "   - xcape"
    echo "   - yq"
    echo ""
    echo_error "Run this script without arguments to execute these actions."
    exit 1
fi

if [ $(id -u) = 0 ]; then
    echo_error "This script shouldn't be run as root."
    exit 1
fi

#if ! [ -f ~/.joplin/Joplin.AppImage ]; then
#    echo_status "Installing Joplin for Desktop [via custom installer]"
#    wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
#fi

if ! which starship >/dev/null; then
    echo_status "Installing starship [via starship.rs/install.sh]"
    curl -sS https://starship.rs/install.sh | sh
fi

if ! which xcape >/dev/null; then
    echo_status "Installing xcape [via github.com/alols/xcape]"
    sudo dnf install git gcc make pkgconfig libX11-devel libXtst-devel libXi-devel
    THISDIR=$(pwd)
    cd /tmp
    git clone https://github.com/alols/xcape.git
    cd /tmp/xcape
    sed -i 's/^PREFIX=.*/PREFIX=\/usr\/local/' Makefile
    sed -i 's/^MANDIR.*/MANDIR?=\/man\/man1/' Makefile
    make
    sudo make install
    cd $THISDIR
    if which xcape >/dev/null; then
        rm -rf /tmp/xcape
    else
        echo_error "Installation of xcape failed"
    fi
fi

if ! which pet >/dev/null; then
    if ! which jq >/dev/null; then
        echo_error "Installation of pet requires jq; skipping"
    else
        echo_status "Installing pet [via github.com/knqyf263/pet]"
        petrpm=$(curl -s https://api.github.com/repos/knqyf263/pet/releases/latest | jq '.assets[] | select(.name|match("linux_amd64.rpm$")) | .browser_download_url' | tr -d \")
        if [[ -z "$petrpm" ]]; then
            echo_error "Installation of pet failed: no linux_amd64.rpm found (maybe the latest release doesn't have one?)"
        else
            sudo dnf install -y "$petrpm"
        fi
    fi
fi

if which npm >/dev/null; then
    # Install global packages in user directory
    if ! [ -d ~/.npm-global ]; then
        mkdir ~/.npm-global
        npm config set prefix '~/.npm-global'
    fi
    export NPM_CONFIG_PREFIX=~/.npm-global
else
    echo_error "NPM isn't installed; skipping installation of npm packages."
fi

if which python >/dev/null; then
    python -m pip install --upgrade pip
    if ! [[ -e ~/.local/bin/vf ]]; then
        echo_status "Installing virtualfish [via pip]"
        python -m pip install --user virtualfish
    fi
    if ! [[ -e ~/.local/bin/jupyter-lab ]]; then
        echo_status "Installing jupyter-lab [via pip]"
        python -m pip install --user jupyterlab
    fi
else
    echo_error "Python isn't installed; skipping installation of Python packages."
fi

if ! which brew >/dev/null; then
    echo_status "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! which brew >/dev/null; then
    echo_error "Homebrew isn't installed; skipping installation of Homebrew packages."
else
    if ! [[ -e /home/linuxbrew/.linuxbrew/bin/yq ]]; then
        echo_status "Installing yq [via brew]"
        brew install yq
    fi
    if ! [[ -e /home/linuxbrew/.linuxbrew/bin/timg ]]; then
        echo_status "Installing timg [via brew]"
        brew install timg
    fi
    if ! [[ -e /home/linuxbrew/.linuxbrew/bin/grex ]]; then
        echo_status "Installing grex [via brew]"
        brew install grex
    fi
fi
