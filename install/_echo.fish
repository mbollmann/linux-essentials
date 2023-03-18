function echo_status
    set_color --bold brblue
    echo -n "*** "
    set_color --bold green
    echo $argv
    set_color normal
end

function echo_error
    set_color --bold red
    echo -n "!!!"
    set_color normal
    set_color --bold brred
    echo "" $argv
    set_color normal
end
