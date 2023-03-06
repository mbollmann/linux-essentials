if test -d ~/.virtualenv
  set -g VIRTUALFISH_HOME ~/.virtualenv
end

if test -d ~/.virtualenvs
  set -g VIRTUALFISH_HOME ~/.virtualenvs
end

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

  if test -d $HOME/repos/scripts
    set -x PATH $PATH $HOME/repos/scripts
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

  if test -f ~/.config/pythonstartup.py
    set -x PYTHONSTARTUP ~/.config/pythonstartup.py
  end

  set -x EDITOR "emacs -nw"
  set -x VISUAL "emacs"
  set -x ALTERNATE_EDITOR "emacs"

  if command -q xcape; and test -z (pgrep xcape)
    xcape -e "#66=Escape"
  end

  # We define our own virtualenv prompt, this hopefully disables warnings from vf?
  set -g VIRTUAL_ENV_DISABLE_PROMPT 1

end

set -x R_LIBS_USER "$HOME/.R/library"

if test -f /home/bollmann/.config/fish/functions/conda.fish
  source /home/bollmann/.config/fish/functions/conda.fish
end

if test -f /home/linuxbrew/.linuxbrew/bin/brew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

if command -s starship >/dev/null
  starship init fish | source
end

if command -v flatpak > /dev/null
  # set XDG_DATA_DIRS to include Flatpak installations

  set -x XDG_DATA_DIRS $XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/bollmann/.local/share/flatpak/exports/share
end
