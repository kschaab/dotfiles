# dotfiles
This repository syncs my dotfiles to other machines. It is somewhat simplisitic in that it just replicates the
repository to ~/dotfiles and that hosts all the dotfiles. Setup is contained in [bootstrap.zsh](bootstrap.zsh).

## Initialization
Initialization is possible by running the [bootstrap.zsh](bootstrap.zsh) script in the root of the repository. This
can be done simply by having `git` and `zsh` on the system and running the command below. The scripts require no
other utilities, for example on Mac the bootstrap script will set up sudoless homebrew, install nerd fonts, etc.
On Linux this runs the overall package manager to manage packages and will require sudo.

```
curl https://raw.githubusercontent.com/kschaab/dotfiles/master/bootstrap.zsh | zsh
```

This will take care of cloning the repository as well as ensuring that bootstrap versions of the dotfiles are placed
in the proper places (for example `~/.zshrc`, `~/.vimrc`, and `~/.config/i3/config`). This is accomplished by
chaining calls to bootstrap scripts for each dotfile. For example [boostrap.zsh](bootstrap.zsh) calls
[vim/setup/bootstrap.zsh](vim/setup/bootstrap.zsh) which in turn places ~/.vimrc and clones Vundle. The placed
`.vimrc` simply sources `~/dotfiles/vim/vimrc`. This bootstrap is designed to be run once.

> Note: All existing dotfiles present on the system will be moved to `~/.bak` upon bootstrap. This process is
controlled by the corresponding `bootstrap.zsh` script, for example
[vim/setup/bootstrap.zsh](vim/setup/bootstrap.zsh) backs up any existing `~/.vimrc`. These scripts rely on `~/.bak`
being present. For that the creation of `~/.bak` directory is controlled by the root [bootstrap.zsh](bootstrap.zsh)
file.

## [zsh](zsh)

I like `zsh` as it provides a bit more flexibility than bash whilst still being mostly compatible with bash. I use
antigen as a bundle provider and Powerlevel 10k for prompt support. These take care of bootstrapping themselves on
first execution so they will not be automatically bootstrapped during the main bootstrap phase. I try to keep things
modular, for example Mac specific initialization is in [zsh/mac.zsh](zsh/mac.zsh).

## [vim](vim)

Vim is pretty simple, it uses Vundle for plugin management and [vim/setup/bootstrap.zsh](vim/setup/bootstrap.zsh)
sets this up as well as running `:PluginInstall` to initialize vim so it is good to go. This requires vim to be
present on the system.
