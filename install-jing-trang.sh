#!/usr/bin/env fish

# jing/trang are not packaged in Fedora; this script automates the process of
# installing them from <https://github.com/relaxng/jing-trang>.
#
# It creates two wrapper scripts to call them in ~/.local/bin.
#
# This script is a quick hack and not particularly robust to things going wrong.

sudo dnf install java-latest-openjdk

set -x JAVA_HOME /usr/lib/jvm/jre-openjdk
if not test -d "$JAVA_HOME"
   echo "!!! Expected directory to exist: $JAVA_HOME"
   exit 1
end

set -l PWDDIR (pwd)
set -l TMPDIR (mktemp --directory)
cd $TMPDIR
git clone https://github.com/relaxng/jing-trang.git
cd jing-trang/
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
    echo "!!! build/{jing,trang}.jar not found"
end

cd $PWDDIR
rm -rf $TMPDIR
