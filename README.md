# linux-essentials

Dot-files, essential packages, and more to set up a Linux installation, kept
here to facilitate setting up a new system or virtual machine.

This configuration has most recently been tested on: **Fedora 40**


## Dot-files

Some of the files, like `.gitconfig` and `.ssh/config`, contain personalized
settings that shouldn't be copied verbatim if you take inspiration from this
repo.

### Shell settings

I use [**fish**](https://fishshell.com/) together with
[**starship**](https://starship.rs/).  My configuration mainly sets up custom
paths, keybindings, and configures some external tools.

There's also an elaborate `.bashrc` here, but since I switched to fish as my
main shell, it hasn't really been kept updated for years.

### Emacs

Emacs configuration is 90% inspired by [the configuration of Vicky
Chijwani](https://github.com/vickychijwani/dotfiles/tree/master/.emacs.d) that
was linked from [this blog
post](http://vickychijwani.me/nuggets-from-my-emacs-part-i/), but has been
heavily modified since.

It currently uses [the Hack typeface](https://sourcefoundry.org/hack/), which
needs to be installed manually, otherwise the configuration won't be fully
loaded.

## Packages

`pkg-fedora/` contains various files that list packages I like to have on my
systems.  Since I'm using Fedora-based distributions, the names correspond to
package names in the Fedora package repositories.

`install-pkg-fedora.sh` is a convenience script to quickly install all packages
from a given file; e.g., to install all the nifty command-line utilities:

```bash
sudo ./install-pkg-fedora.sh pkg-fedora/cli.txt
```

### DisplayLink driver

For laptops with docking stations, the DisplayLink driver might be required to
make a multi-monitor setup work.  This is currently not included in Fedora
package repos, but can be obtained here:

https://github.com/displaylink-rpm/displaylink-rpm/releases

It needs to be updated manually after distribution upgrades.
