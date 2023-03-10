#!/bin/bash

echo_status() {
    echo -e "\033[1m\033[32m*** \033[94m$1\033[0m"
}

deploy() {
    echo_status "Syncing dot-files"
    rsync -au dot-files/ ~/
}

check_for_newer() {
    echo_status "Checking for dot-files with changes that are not in the repo"
    cd dot-files/
    find . -type f -exec diff -q ~/{} {} \;
    find .config/ -mindepth 1 -prune -type d -exec diff -r ~/{} {} \;
    diff -r ~/.emacs.d/ .emacs.d/
    cd ..
}

# Dry-run
rsync -ni -avu dot-files/ ~/

echo ""
echo -e "\033[1m\033[4mSync changes above to ~/?\033[0m"
echo -e "--> This might \033[31m\033[1mOVERWRITE EXISTING FILES!\033[0m "
select yn in "Yes" "No"
do
    case $yn in
        Yes ) deploy; break;;
        No ) break;;
    esac
done

check_for_newer
