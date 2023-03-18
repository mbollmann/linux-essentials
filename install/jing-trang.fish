#!/usr/bin/env fish

# jing/trang are not packaged in Fedora; this script automates the process of
# installing them from <https://github.com/relaxng/jing-trang>.
#
# It creates two wrapper scripts to call them in ~/.local/bin.
#
# This script is a quick hack and not particularly robust to things going wrong.

source (dirname (status --current-filename))/_echo.fish

if fish_is_root_user
    echo_error "This script shouldn't be run as root."
    exit 1
end

if command -q jing
    echo_status "jing-trang already installed."
    exit 0
end

echo_status "Installing jing-trang [via github.com/relaxng/jing-trang]"

if test -z "$JAVA_HOME"
    sudo dnf install java-latest-openjdk
    set -x JAVA_HOME /usr/lib/jvm/jre-openjdk
    if not test -d "$JAVA_HOME"
        echo_error "jing-trang: Can't locate OpenJDK -- directory doesn't exist: $JAVA_HOME"
        echo_error "Installation of jing-trang failed."
        exit 1
    end
end

set -l PWDDIR (pwd)
set -l TMPDIR (mktemp --directory)
git clone https://github.com/relaxng/jing-trang.git "$TMPDIR"
cd "$TMPDIR"
./ant
if test -f build/jing.jar ; and test -f build/trang.jar
    mkdir -p ~/.local/bin
    mkdir -p ~/.local/opt/jing-trang
    cp build/jing.jar ~/.local/opt/jing-trang/
    cp build/trang.jar ~/.local/opt/jing-trang/
    echo "#!/bin/bash"\n\n"java -jar $HOME/.local/opt/jing-trang/jing.jar" '"$@"' > ~/.local/bin/jing
    chmod a+x ~/.local/bin/jing
    echo "#!/bin/bash"\n\n"java -jar $HOME/.local/opt/jing-trang/trang.jar" '"$@"' > ~/.local/bin/trang
    chmod a+x ~/.local/bin/trang
else
    echo_error "jing-trang: build/{jing,trang}.jar not found"
end

cd "$PWDDIR"
rm -rf "$TMPDIR"

if not command -q jing
    echo_error "Installation of jing-trang failed."
    exit 1
end
