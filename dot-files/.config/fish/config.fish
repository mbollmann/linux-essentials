set -g VIRTUALFISH_HOME ~/.virtualenv
if status --is-interactive
  # Enable virtualfish
  #if python3 -m virtualfish >/dev/null ^/dev/null
  #  eval (python3 -m virtualfish)
  #end

  if command -s keychain >/dev/null
    keychain --quiet --clear --ignore-missing $HOME/.ssh/id_rsa $HOME/.ssh/id_dsa $HOME/.ssh/id_ed25519
  end

  if test -d $HOME/scripts
    set -x PATH $PATH $HOME/scripts
  end

  if test -d $HOME/.cargo/bin
    set -x PATH $PATH $HOME/.cargo/bin
  end

  if test -d $HOME/.local/bin
    set -x PATH $PATH $HOME/.local/bin
  end

  if test -d $HOME/.npm-global/bin
    set -x PATH $PATH $HOME/.npm-global/bin
  end

  if test -d /var/lib/snapd/snap/bin
    set -x PATH $PATH /var/lib/snapd/snap/bin
  end

  set -x EDITOR "emacs -nw"
  set -x VISUAL "emacs"
  set -x ALTERNATE_EDITOR "emacs"

  # We define our own virtualenv prompt, this hopefully disables warnings from vf?
  set -g VIRTUAL_ENV_DISABLE_PROMPT 1

end

if test -f /home/bollmann/.config/fish/functions/conda.fish
  source /home/bollmann/.config/fish/functions/conda.fish
end

if command -s starship >/dev/null
  starship init fish | source
end
