#!/bin/bash

echo_status() {
    echo -e "\033[1m\033[32m*** \033[94m$1\033[0m"
}

deploy() {
    echo_status "Syncing dot-files"
    rsync -au --exclude-from=.sync-exclude dot-files/ ~/

    if ! rsync -ni -avu --include-from=.sync-exclude --exclude="*" dot-files/ ~/ | grep -q "total size is 0 " ; then
        echo -e "--> \033[31m\033[1mThere are files that should be synced but can't\033[0m, because they contain secrets. "
        rsync -ni -avu --include-from=.sync-exclude --exclude="*" dot-files/ ~/
    fi
}

check_for_newer() {
    echo_status "Checking for dot-files that differ between user directory and repo"
    cd dot-files/
    find . -type f -exec diff -q ~/{} {} \;
    cd ..
}

# Dry-run
rsync -ni -avu --exclude-from=.sync-exclude dot-files/ ~/

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
