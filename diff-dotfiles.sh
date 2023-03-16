#!/bin/bash

echo_status() {
    echo -e "\033[1m\033[32m***\033[94m" $* "\033[0m"
}

git_diff() {
    echo_status "Diffing dot-files between" ~ and "repository"
    cd dot-files/
    find . -type f -name ".*" -exec git diff --color=always {} ~/{} \;
    find .ssh/ -type f -exec git diff --color=always {} ~/{} \;
    find .config/ -type f -exec git diff --color=always {} ~/{} \;
    find   .emacs.d/ -not -path '*/auto-save-list*'\
                     -not -path '*/my-desktop-sessions*'\
                     -not -name 'tramp'\
                     -not -name 'bookmarks'\
                     -not -name 'ac-comphist.dat'\
                     -not -path '*.emacs.d/'\
                     -not -path '*/elpa*'\
                     -type f\
                     -exec git diff --color=always {} ~/{} \;
    cd ..
}

norm_diff() {
    echo_status "Diffing dot-files between" ~ and "repository"
    cd dot-files/
    find . -type f -name ".*" -exec diff {} ~/{} \;
    find .ssh/ -type f -exec diff {} ~/{} \;
    find .config/ -type f -exec diff {} ~/{} \;
    find   .emacs.d/ -not -path '*/auto-save-list*'\
                     -not -path '*/my-desktop-sessions*'\
                     -not -name 'tramp'\
                     -not -name 'bookmarks'\
                     -not -name 'ac-comphist.dat'\
                     -not -path '*.emacs.d/'\
                     -not -path '*/elpa*'\
                     -type f\
                     -exec diff {} ~/{} \;
    cd ..
}

check_for_missing() {
    echo_status "Brief diff, including missing files"
    cd dot-files/
    find .config/ -mindepth 1 -prune -type d -exec diff -rq ~/{} {} \;
    find   .emacs.d/ -not -path '*/auto-save-list*'\
                     -not -path '*/my-desktop-sessions*'\
                     -not -name 'tramp'\
                     -not -name 'bookmarks'\
                     -not -name 'ac-comphist.dat'\
                     -not -path '*.emacs.d/'\
                     -not -path '*/elpa*'\
                     -type f\
                     -exec diff -rq {} ~/{} \;
    cd ..
}

if which git >/dev/null; then
    git_diff
else
    norm_diff
fi

check_for_missing
