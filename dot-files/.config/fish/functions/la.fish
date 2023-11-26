function la --wraps eza --description "eza --icons -Fa"
    #ls -ACF --color=always $argv
    eza --icons --classify --all $argv
end
