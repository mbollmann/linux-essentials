function install_fisher --description "Fetch the 'fisher' plugin manager and install it"
    if functions -q fisher
        echo "!!! looks like fisher is already installed; skipping"
    else
        curl -sL https://git.io/fisher | source && fisher update
    end
end
