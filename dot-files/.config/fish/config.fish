if status --is-interactive
  # Enable virtualfish
  if python3 -m virtualfish >/dev/null ^/dev/null
    eval (python3 -m virtualfish)
    set -g VIRTUALFISH_HOME ~/.virtualenv
  end

  if command -s keychain >/dev/null
    keychain --quiet --clear --ignore-missing $HOME/.ssh/id_rsa $HOME/.ssh/id_dsa
  end

  if test -d $HOME/scripts
    set -x PATH $PATH $HOME/scripts
  end

  set -x EDITOR "emacs -nw"
  set -x VISUAL "emacs"
  set -x ALTERNATE_EDITOR "emacs"
end
