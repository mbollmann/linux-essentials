function lt --wraps exa --description "exa --icons -lFhT -L 2 --git"
    exa --long --header --git --icons --classify --tree --level=2 $argv
end
