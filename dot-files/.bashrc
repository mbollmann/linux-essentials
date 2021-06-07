# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    git_prompt='\[\033[01;35m\]$(__git_ps1) '
else
    git_prompt=' '
fi

if [ $(id -u) -eq 0 ]; then
    # root prompt
    prompt_color_user='\[\033[01;31m\]'
    prompt_color_last='\[\033[01;31m\]'
else
    # normal user prompt
    prompt_color_user='\[\033[01;32m\]'
    prompt_color_last='\[\033[01;34m\]'
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}'$prompt_color_user'\u@\h\[\033[00m\] \[\033[01;34m\]\w'$git_prompt$prompt_color_last'↯\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt git_prompt prompt_color_user prompt_color_last

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# if keychain is available, use it
if [ -x /usr/bin/keychain ]; then
  /usr/bin/keychain --quiet --clear --ignore-missing \
      $HOME/.ssh/id_rsa \
      $HOME/.ssh/id_dsa
fi

# yay for custom scripts!
if [ -d $HOME/scripts ]; then
    export PATH=$HOME/scripts:$PATH
fi

if [ -d $HOME/.local/bin ]; then
    export PATH=$HOME/.local/bin:$PATH
fi

if [ -d $HOME/.cargo/bin ]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

if [ -d $HOME/.npm-global/bin ]; then
    export PATH=$HOME/.npm-global/bin:$PATH
fi

if [ -d /var/lib/snapd/snap/bin ]; then
    export PATH=/var/lib/snapd/snap/bin:$PATH
fi

# use Emacs whenever possible
export ALTERNATE_EDITOR="emacs"
export EDITOR="emacs -nw"
export VISUAL="emacs"

################################################################################
# An enhanced 'cd' - push directories
# onto a stack as you navigate to it.
#
# The current directory is at the top
# of the stack.
#
function stack_cd {
    if [ -z "$1" ]; then
        # the normal cd behavior is to enter $HOME if no
        # arguments are specified
        pushd $HOME > /dev/null
    else
        # use the pushd bash command to push the directory
        # to the top of the stack, and enter that directory
        pushd "$1" > /dev/null
    fi
}
# the cd command is now an alias to the stack_cd function
#
alias cd=stack_cd
# Swap the top two directories on the stack
#
function swap {
    pushd > /dev/null
}
# s is an alias to the swap function
alias s=swap
# Pop the top (current) directory off the stack
# and move to the next directory
#
function pop_stack {
    popd > /dev/null
}
alias p=pop_stack
# Display the stack of directories and prompt
# the user for an entry.
#
# If the user enters 'p', pop the stack.
# If the user enters a number, move that
# directory to the top of the stack
# If the user enters 'q', don't do anything.
#
function display_stack
{
    dirs -v
    echo -n "#: "
    read dir
    if [[ $dir = 'p' ]]; then
        pushd > /dev/null
    elif [[ $dir != 'q' ]]; then
        d=$(dirs -l +$dir);
        popd +$dir > /dev/null
        pushd "$d" > /dev/null
    fi
}
alias d=display_stack
################################################################################
################################################################################
# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }
# Copy current working directory
alias cbwd="pwd | cb"
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 1 | cb"
################################################################################

# added by Pew
if [ -x /usr/local/bin/pew ]; then
    source $(pew shell_config)
fi

[[ -r ~/.bashrc_local ]] && . ~/.bashrc_local
