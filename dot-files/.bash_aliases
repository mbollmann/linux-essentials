# ~/.bash_aliases

if [ -f ~/.inputrc ]; then
    export INPUTRC=~/.inputrc
fi

# be careful. be very, very careful.
alias rm='rm -i'
alias mv='mv -i'

# some more ls aliases
alias l='ls -CF'
alias l.='ls -CFd .[^.]*'
alias ll='ls -lF'
alias la='ls -AF'
alias lla='ls -lAF'
alias ll.='ls -lAFd .[^.]*'

# convenience
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias e='emacs'
alias et='emacs -nw'
alias please='sudo $(fc -ln -1)'
alias ffs='sudo $(fc -ln -1)'
alias where='which'

# thefuck, if it's installed
if command -v thefuck >/dev/null 2>&1; then
   eval "$(thefuck --alias)"
fi
