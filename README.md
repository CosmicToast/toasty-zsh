Toast Zsh
=========

My Personal Config
------------------

### About ###
I like experimenting.
I also like having a usable shell.
I also rather disliked how having multiple zsh configs meant clottering up your home dir. I wanted to be able to change between them on a whim.

And thus, Toast Zsh was born.

### Basic Usage ###
- Clone the repository somewhere into your home directory (~/.zsh is recommended). Use `--recursive` if you want to avoid initializing submodules in step 3.
- Enter that directory.
- Run `git submodule update --init --recursive`
- Symlink a *.zrc file of your choosing into ~/.zshrc

To update: run `toast-zsh-upgrade`.

### Advanced Usage ###
$zshd/config Defines:
- $zshd: the directory where Toast Zsh lives (suggested: ~/.zsh), to be used in other scripts. (PS: $0 is actually broken inside of init scripts, and resolves to /bin/zsh)
- $zrc: the current zshrc in use, can be used by a zshrc to block sourcing itself when it isn't zshrc

$zshd/pre: file that should be run before any plugin-specific configuration, good place to define functions. Currently defines several management-related ones.

$zshd/post: file that should be run after any plugin-specific configuration, good place to unhash functions and source any generic files (~/.zshrc.local, etc)

### Writing Your Own *.zrc ###
First, source ${${(%):-%x}:A:h}/config.

Translation: (%) is prompt expansion (so we can use -%x), -%x gives us the name of the file we're in (even if we're in an init script). Then we expand that into the path to the directory (even through symlinks) using :A:h (:A for absolute path, :h to get directory). That sources the config file that defines $zshd, which is equivalent to this.

Then, if it exists and is readable, source $zshd/pre.

Now do all of your plugin configuration. No files or folders should be created outside of $zshd. Most systems should allow you to customize this (e.g the ZSH variable with OMZ, etc.).

Good practice is to have the repo as the name of the plugin manager, and if it requires a separate directory, it should be the name with a .conf appended to it (e.g zgen for the zgen source and zgen.conf for the directory with the plugins).

Finally, if it exists and is readable, source $zshd/post.
