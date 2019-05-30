# linux-essentials

Dot-files, essential packages, and more to set up a Linux installation, kept
here to facilitate setting up a new system or virtual machine.

This configuration has most recently been tested on: **Fedora 30**


## Dot-files

The following files **contain personalized settings** and should probably
**not** be copied verbatim if you take inspiration from this repo:

+ `.gitconfig`
+ `.ssh/config`

### Shell settings

`.bashrc` and its companions mainly do the following:

+ set up history browsing/completion with arrow-up/-down
+ define a colorful prompt
+ include git branches in the prompt (http://code-worrier.com/blog/git-branch-in-bash-prompt/)
+ define an enhanced `cd` that keeps track of visited directories (access with `d`(isplay), `p`(op), or `s`(wap))
+ define some aliases that I commonly use

Nowadays I mainly use [**fish**](https://fishshell.com/), for which a similar
configuration is included.  Using this will produce a string of errors on first
run, as necessary plugins aren't yet installed.  They should be fetched and
installed automatically with the `fisher` command.

### Emacs

Emacs configuration is 90% inspired by [the configuration of Vicky
Chijwani](https://github.com/vickychijwani/dotfiles/tree/master/.emacs.d) that
was linked from [this blog
post](http://vickychijwani.me/nuggets-from-my-emacs-part-i/), but has been
heavily modified since.

It currently uses [the Hack typeface](https://sourcefoundry.org/hack/), which
needs to be installed manually, otherwise the configuration won't be fully
loaded.

### Miscellanea

+ `.Xmodmap` binds the Caps-Lock key to the Escape keycode.
+ There are some minor customizations for tools like `ack` and `thefuck`.

**TODO:** I used to have a tmux configuration here, but it's currently
broken. Need to investigate.


## Packages

`pkg-fedora/` contains various files that list packages I like to have on my
systems.  Since I'm using Fedora-based distributions, the names correspond to
package names in the Fedora package repositories.

`install-pkg-fedora.sh` is a convenience script to quickly install all packages
from a given file; e.g., to install all the nifty command-line utilities:

```bash
sudo ./install-pkg-fedora.sh pkg-fedora/cli.txt
```
