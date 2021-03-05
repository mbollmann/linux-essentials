function pwd_home -d "Print the current working directory minus the HOME prefix"
    set -l home ~
    string replace $home/ "" (pwd)
end
