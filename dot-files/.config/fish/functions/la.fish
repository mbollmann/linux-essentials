function la --wraps exa --description "exa --icons -Fa"
    #ls -ACF --color=always $argv
    exa --icons --classify --all $argv
end
