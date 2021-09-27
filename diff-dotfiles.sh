#!/bin/bash

echo_status() {
    echo -e "\033[1m\033[32m*** \033[94m$1\033[0m"
}

diff() {
    echo_status "Diffing dot-files in home directory"
    cd dot-files/
    find . -type f -name ".*" -exec diff -q {} ~/{} \;
    echo_status "Diffing SSH configuration"
    find .ssh/ -type f -exec diff -q {} ~/{} \;
    echo_status "Diffing application-specific configuration"
    find .config/ -type f -exec diff -q {} ~/{} \;
    echo_status "Diffing Emacs configuration"
    find   .emacs.d/ -not -path '*/auto-save-list*'\
                     -not -path '*/my-desktop-sessions*'\
                     -not -name 'tramp'\
                     -not -name 'bookmarks'\
                     -not -name 'ac-comphist.dat'\
                     -not -path '*.emacs.d/'\
                     -not -path '*/elpa*'\
                     -type f\
                     -exec diff -q {} ~/{} \;
}

diff
