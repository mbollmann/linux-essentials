if test -d ~/.virtualenv
    set -g VIRTUALFISH_HOME ~/.virtualenv
end

if test -d ~/.virtualenvs
    set -g VIRTUALFISH_HOME ~/.virtualenvs
end

if status is-interactive
    if command -q keychain
        keychain --quiet --clear --ignore-missing $HOME/.ssh/id_rsa $HOME/.ssh/id_dsa $HOME/.ssh/id_ed25519
    end

    # Custom paths to be added to $PATH, if they exist
    fish_add_path -g \
        "$HOME/scripts" "$HOME/repos/scripts" "$HOME/.cargo/bin" "$HOME/.local/bin" \
        "$HOME/.npm-global/bin" "/var/lib/snapd/snap/bin"

    if test -f ~/.config/pythonstartup.py
        set -x PYTHONSTARTUP ~/.config/pythonstartup.py
    end

    set -x EDITOR "emacs -nw"
    set -x VISUAL "emacs"
    set -x ALTERNATE_EDITOR "emacs"

    # We define our own virtualenv prompt, this hopefully disables warnings from vf?
    set -g VIRTUAL_ENV_DISABLE_PROMPT 1

    # Make Caps Lock behave like Escape if pressed shortly
    if command -q xcape; and test -z (pgrep xcape)
        xcape -e "#66=Escape"
    end

    if command -q bat
        # Man pager uses 'bat' command
        set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
        set -x MANROFFOPT "-c"
    end

    set -x FZF_DEFAULT_OPTS '--cycle --border=top --layout=reverse --height=90% --preview-window=nowrap --marker="*" --bind="ctrl-t:toggle-preview"'

    # Keybindings and options for fzf.fish plugin
    if functions -q fzf_configure_bindings
        fzf_configure_bindings --directory=\cf --git_status=\e\cg

        if command -q exa
            set -x fzf_preview_dir_cmd "exa --all --icons --classify --color=always"
        end

        if functions -q preview
            set -x fzf_preview_file_cmd preview
        end

        if functions -q et
            set -x fzf_directory_opts --bind "ctrl-e:execute(et {})+abort,ctrl-o:execute(open {} &> /dev/null)+abort" --header "Ctrl-E to open in Emacs, Ctrl-O to open in desktop application"
        else
            set -x fzf_directory_opts --bind "ctrl-e:execute($EDITOR {})+abort,ctrl-o:execute(open {} &> /dev/null)+abort" --header "Ctrl-E to open in $EDITOR, Ctrl-O to open in desktop application"
        end
        set -x fzf_history_opts --with-nth=4.. --preview=''
        set -x fzf_processes_opts --bind "ctrl-r:reload(ps -A -opid,command),ctrl-k:execute-silent(kill (string split --no-empty --field=1 -- ' ' {}))+reload-sync(sleep .4; ps -A -opid,command)" --header "Ctrl-R to reload, Ctrl-K to send SIGTERM directly"

        if functions -q __mmb_change_directory
            bind --user \ec __mmb_change_directory
            bind --user \eC '__mmb_change_directory --hidden'
        end
    end

    if functions -q __mmb_list_current_token
        bind --user \el __mmb_list_current_token
    end

    bind --user \e\' __fish_toggle_comment_commandline
end

set -x R_LIBS_USER "$HOME/.R/library"

if test -f /home/bollmann/.config/fish/functions/conda.fish
    source /home/bollmann/.config/fish/functions/conda.fish
end

if test -f /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    set --append --path -x fish_complete_path /home/linuxbrew/.linuxbrew/share/fish/vendor_completions.d
end

# Starship prompt
if command -q starship
    starship init fish | source
end

if command -v flatpak > /dev/null
    # set XDG_DATA_DIRS to include Flatpak installations
    set --append --path -x XDG_DATA_DIRS /var/lib/flatpak/exports/share /home/bollmann/.local/share/flatpak/exports/share
end

if not functions -q fisher
    echo "!!! fisher is not installed; run 'install_fisher' to fetch it"
end
