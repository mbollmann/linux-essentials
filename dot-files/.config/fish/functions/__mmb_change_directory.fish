function __mmb_change_directory --description "Search for subdirectory to cd into."
    set -l options  "h/hidden"
    argparse $options -- $argv

    # Directly use fd binary to avoid output buffering delay caused by a fd alias, if any.
    # Debian-based distros install fd as fdfind and the fd package is something else, so
    # check for fdfind first. Fall back to "fd" for a clear error message.
    set fd_cmd (command -v fdfind || command -v fd  || echo "fd")
    set --append fd_cmd --color=always --type=directory $fzf_fd_opts

    if set -q _flag_hidden
        set --append fd_cmd "-H"
    end

    # $fzf_dir_opts is the deprecated version of $fzf_directory_opts
    set fzf_arguments --no-multi --ansi $fzf_dir_opts $fzf_directory_opts
    # ... these ones override what's in fzf_directory_opts
    set --append fzf_arguments --bind "ctrl-o:execute(open {} &> /dev/null)+abort" --header "Ctrl-O to open in desktop application"
    set token (commandline --current-token)
    # expand any variables or leading tilde (~) in the token
    set expanded_token (eval echo -- $token)
    # unescape token because it's already quoted so backslashes will mess up the path
    set unescaped_exp_token (string unescape -- $expanded_token)

    # If the current token is a directory and has a trailing slash,
    # then use it as fd's base directory.
    if string match --quiet -- "*/" $unescaped_exp_token && test -d "$unescaped_exp_token"
        set --append fd_cmd --base-directory=$unescaped_exp_token
        # use the directory name as fzf's prompt to indicate the search is limited to that directory
        set --prepend fzf_arguments --prompt="Change Directory $unescaped_exp_token> " --preview="_fzf_preview_file $expanded_token{}"
        set file_path_selected $unescaped_exp_token($fd_cmd 2>/dev/null | _fzf_wrapper $fzf_arguments)
    else
        set --prepend fzf_arguments --prompt="Change Directory> " --query="$unescaped_exp_token" --preview='_fzf_preview_file {}'
        set file_path_selected ($fd_cmd 2>/dev/null | _fzf_wrapper $fzf_arguments)
    end

    if test $status -eq 0; and not test -z "$file_path_selected"
        builtin cd "$file_path_selected"
        commandline -t ""
    end

    commandline --function repaint
end
