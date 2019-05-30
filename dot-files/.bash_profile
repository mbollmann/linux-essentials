# ~/.bash_profile: clone .bashrc

[[ -r ~/.bashrc ]] && . ~/.bashrc

if hash fortune 2>/dev/null; then
    [[ "$PS1" ]] && echo -e "\e[00;33m$(fortune)\e[00m"
fi
