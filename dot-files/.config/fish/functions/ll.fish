function ll --wraps exa --description "exa --icons -lFh --git"
    #ls -lhAF --color=always $argv
    exa --long --header --git --icons --classify $argv
end
