function lt --wraps eza --description "eza --icons -lFhT -L 2 --git"
    eza --long --header --git --icons --classify --tree --level=2 $argv
end
