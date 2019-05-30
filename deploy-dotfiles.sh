#!/bin/bash

echo_status() {
    echo -e "\033[1m\033[32m*** \033[94m$1\033[0m"
}

deploy() {
    echo_status "Copying dot-files in home directory"
    cp dot-files/.* ~/
    echo_status "Copying SSH configuration"
    cp -r -u dot-files/.ssh ~/
    echo_status "Copying application-specific configuration"
    cp -r dot-files/.tmux ~/
    cp -r dot-files/.config ~/
    echo_status "Synchronizing Emacs configuration"
    find ~/.emacs.d/ -not -path '*/auto-save-list*'\
                     -not -path '*/my-desktop-sessions*'\
                     -not -name 'tramp'\
                     -not -name 'bookmarks'\
                     -not -name 'ac-comphist.dat'\
                     -not -path '*.emacs.d/'\
                     -not -path '*/elpa*'\
                     -delete
    cp -r dot-files/.emacs.d ~/
}
deploy_root() {
    echo_status "Copying dot-files in home directory"
    sudo cp dot-files/.bash* /root/
    sudo cp dot-files/.inputrc /root/
}

echo -e "\033[1m\033[4mDeploy all dot-files to ~/?\033[0m"
echo -e "--> This will \033[31m\033[1mOVERWRITE EXISTING FILES!\033[0m "
select yn in "Yes" "No"
do
    case $yn in
        Yes ) deploy; break;;
        No ) break;;
    esac
done

echo " "
echo -e "\033[1m\033[4mDeploy all bash-related dot-files to /root/?\033[0m"
echo -e "--> This will \033[1m\033[31mOVERWRITE EXISTING FILES!\033[0m "
select yn in "Yes" "No"
do
    case $yn in
        Yes ) deploy_root; break;;
        No ) break;;
    esac
done
