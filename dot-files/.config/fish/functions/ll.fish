function ll
    #ls -lhAF --color=always $argv
    exa --long --header --git --icons --classify $argv
end
