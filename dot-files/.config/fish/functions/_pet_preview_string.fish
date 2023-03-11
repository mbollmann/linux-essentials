function _pet_preview_string
    set_color blue --bold
    echo $argv | sed 's/^\[// ; s/\]: .*//'
    set_color normal
    echo ""
    echo $argv | sed 's/.*]: // ; s/#.*//' | bat -p -f -l Fish
    if string match -e -q "#" "$argv"
        echo
        echo $argv | sed 's/[^#]*#/#/' | bat -p -f -l CSS
    end
end
