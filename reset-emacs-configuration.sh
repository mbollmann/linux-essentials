#!/bin/bash

deploy_emacs() {
    echo_status "Copying Emacs configuration"
    find ~/.emacs.d/ -not -path '*/auto-save-list*'\
                     -not -path '*/my-desktop-sessions*'\
                     -not -name 'tramp'\
                     -not -name 'bookmarks'\
                     -not -name 'ac-comphist.dat'\
                     -not -path '*.emacs.d/'\
                     -not -path '*/elpa*'\
                     -delete
    cp dot-files/.emacs ~/.emacs
    cp -r dot-files/.emacs.d ~/
}

echo -e "\033[1m\033[4mReset ~/.emacs.d/ to the contents of this repo?\033[0m"
echo -e "--> This will \033[31m\033[1mDELETE EXISTING FILES!\033[0m "
select yn in "Yes" "No"
do
    case $yn in
        Yes ) deploy_emacs; break;;
        No ) break;;
    esac
done
