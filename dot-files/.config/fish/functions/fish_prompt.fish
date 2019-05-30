function fish_prompt
    set -l status_copy $status
    set -l pwd_info (pwd_info "/")
    set -l dir
    set -l base
    set -l glyph

    set -l hex_color_blue 87AFFF
    set -l hex_color_green 66CDA0
    set -l hex_color_magenta EE99DD
    set -l hex_color_red DC322F

    set -l color_error (set_color -o $hex_color_red)
    set -l color_git (set_color -o $hex_color_magenta)
    set -l color_glyph (set_color -o $hex_color_blue)
    set -l color_host (set_color -o $hex_color_green)
    set -l color_path (set_color $hex_color_blue)
    set -l color_path_base (set_color -o $hex_color_blue)
    set -l color_root (set_color -o $hex_color_red)

    set -l color_normal (set_color normal)

    echo -sn ""

    if test ! -z "$SSH_CLIENT"
        echo -sn "$color_host"(host_info "user@host")"$color_normal "
    else
        echo -sn "$color_host"(host_info "host")"$color_normal "
    end

    if test "$PWD" = ~
        set base "~"
    else if pwd_is_home
        set dir "~/"
    else
        if test "$PWD" = /
            set base "/"
        else
            set dir "/"
        end
    end

    if test ! -z "$pwd_info[1]"
        set base "$pwd_info[1]"
    end

    if test ! -z "$pwd_info[2]"
        set dir "$dir$pwd_info[2]/"
    end

    echo -sn "$color_path$dir$color_path_base$base$color_normal"

    if test ! -z "$pwd_info[3]"
        echo -sn "$color_path/$pwd_info[3]"
    end

    if set branch_name (git_branch_name)
        set -l git_glyph ""

        if git_is_dirty
            set git_glyph "$git_glyph!"
        end
        if git_is_staged
            set git_glyph "$git_glyph="
        end
        #if git_is_stashed
        #    set git_glyph "$git_glyph\$"
        #end
        if test (git_untracked_files) -gt 0
            set git_glyph "$git_glyph%"
        end
        if test -n "$git_glyph"
            set git_glyph " $git_glyph"
        end

        set git_glyph "$git_glyph"(git_ahead " +" " -" " +-")

        echo -sn " $color_git($branch_name$git_glyph)$color_normal"
    end

    if test 0 -eq (id -u "$USER")
        set glyph " $color_root###"
    else
        set glyph " ↯"
    end

    if test "$status_copy" -ne 0
        set color_glyph "$color_error"
    end

    echo -sn "$color_glyph$glyph$color_normal "
end
