function fish_right_prompt
    set -l status_copy $status
    set -l status_code $status_copy

    set -l hex_color_magenta EE99DD
    set -l hex_color_dark_goldenrod B8860B
    set -l hex_color_red DC322F

    set -l color_venv_desc (set_color $hex_color_magenta)
    set -l color_venv (set_color -o $hex_color_magenta)
    set -l color_info (set_color $hex_color_dark_goldenrod)
    set -l color_normal (set_color normal)
    set -l color_error (set_color -o $hex_color_red)
    set -l color "$color_normal"

    switch "$status_copy"
        case 0 "$__mono_status_last"
            set status_code
    end

    #set -g __mono_status_last $status_copy

    #if test "$status_copy" -ne 0
    #    set color "$color_error"
    #end

    if set -l job_id (last_job_id)
        echo -sn "$color_info%$job_id$color_normal "
    end

    if test ! -z "$status_code"
        echo -sn "$color_error$status_code$color_normal "
    end

    if test "$CMD_DURATION" -gt 250
        set -l duration (echo $CMD_DURATION | humanize_duration)
        echo -sn "$color_info$duration$color_normal "
    end

    if test -n "$VIRTUAL_ENV"
        set -l venv_name (basename $VIRTUAL_ENV)
        echo -sn "$color_venv_desc(venv: $color_venv$venv_name$color_normal$color_venv_desc)$color_normal "
    end
end
