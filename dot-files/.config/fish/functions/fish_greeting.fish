function fish_greeting
  set -l hour (date "+%k")
  if status --is-login
    set_color -o purple
    if test $hour -ge 22 -o $hour -le 4
      echo "Shouldn't you be sleeping?"
    else if test $hour -ge 19
      echo "Good evening!"
    else if test $hour -ge 14
      echo "Good afternoon!"
    else if test $hour -ge 12
      echo "Good day!"
    else
      echo "Good morning!"
    end
    echo "This is "(hostname)", "
    echo "  running "(uname -sr)", "
    echo "  "(uptime -p)" (since "(uptime -s)")."
    set_color normal
    echo ""
  end
  if command -s fortune >/dev/null
    set_color yellow; fortune; set_color normal
  end
end
