function ll --wraps eza --description "eza --icons -lFh --git"
    #ls -lhAF --color=always $argv
    eza --long --header --git --icons --classify $argv
end
