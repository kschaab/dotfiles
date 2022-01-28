# dotfiles
This repository syncs my dotfiles to other machines. It is somewhat simplisitic in that it just replicates the
repository to ~/dotfiles and that hosts all the dotfiles. Setup is contained in [bootstrap.zsh](bootstrap.zsh).

## Initialization
Initialization is possible by running the [bootstrap.zsh](bootstrap.zsh) script in the root of the repository. This
can be done simply by having `git` and `zsh` on the system and running the command below. The scripts require no
other utilities, for example on Mac the bootstrap script will set up sudoless homebrew, install nerd fonts, etc.
On Linux this runs the overall package manager to manage packages and **will require sudo**.

```
curl https://raw.githubusercontent.com/kschaab/dotfiles/master/bootstrap.zsh | zsh
```

This will take care of cloning the repository as well as ensuring that bootstrap versions of the dotfiles are placed
in the proper places (for example `~/.zshrc`, `~/.vimrc`, and `~/.config/i3/config`). This is accomplished by
using the GNU stow utility which will symlink the files from the local enlistment.

## zsh
zsh will be initialized with portable settings, for example POWERLEVEL prompt will be the same across all machines.

## vim
vim will also be initialized with portable settings.  Upon setup all vundle packages will be installed.

## ~/bin/share
Shared scripts will live here. Each script any os dependent scripts will be installed in the os dependent location.

