Toast Zsh
=========

[![license]](LICENSE.md)

My Personal Config
------------------

### About ###
I like experimenting.
I also like having a usable shell.

There was an obvious base from which I wanted to build, but other solutions were all rather too expansive or too limited. Meanwhile I also wanted unique-to-each-machine configs that would be easy to setup.

And thus, Toasty Zsh was born.

### tl;dr ###
It does some setup stuff to make your shell behave more consistently, adds some convenient directories to fpath, automatically sources stuff you drop in other convenient directories, and allows you to easily use drag and drop plugins.

#### Quickstart ####
1. Clone this repository somewhere
2. Link the zshrc file within it into ~/.zshrc
3. Create the ~/.zsh directory
4. Copy the examples/zshrc.local file from the repo into ~/.zsh/zshrc.local
5. Restart your shell and enjoy!

See the information below on how to expand on this relatively basic setup.

### What does it do... more specifically? ###
#### Variables ####
Toasty Zsh will set two important variables, and a couple less important ones (shown below).

- zd: the directory where your user configuration will live.
- zshd: the directory where toasty zsh is installed.

#### Execution ####
1. Use zshy magic to find `$zshd/config` and source it. (distributed) This will set the variables mentioned above.
2. Create a -T type typeset between SPATH/spath and APATH/apath. For more details, see `zshbuiltins(1)/typeset \[/-T/-T`.
3. Set spath and apath to their default values (the `plugins` and `source` subidrectories respectively of `$zd` followed by `$zshd`.
4. Set the fpath to `./functions`, `./completions` and `./prompts` of `$zd` followed by `$zshd`.
5. Source `$zd/pre` if it exists to allow users to overwrite the above default.
6. Autoload (for more details, see `zshbuiltins(1)/autoload`) the sourceall function (see below) and call `sourceall zsh`.
7. Source `$zd/zshrc.local` if it exists - most of your configuration should be done here.
8. Run compinit - please don't do this yourself.

### API ###
#### Sourced Files ####
The following files are distributed with Toasty Zsh, and will be sourced every time the shell is started.

- aliases.zsh : add commonly used aliases. Currently supports:
    - `grep` -> `grep --color=auto`
    - `ls`   -> `ls --color -auto`
    - `ll`   -> `ls -lh`
    - `l`    -> `ll`
    - `la`   -> `l -a`
- bindkeys.zsh : use terminfo keys to set up common emacs-style shortcuts, such as home and arrow keys.
- completions.zsh : edit various completion options.
- env.zsh : set some generally (I hope) agreeable environment variables, for baseline deployments.
- options.zsh : enable various opinionated options that I like and think improve the shell experience.

#### Provided Prompts ####
The following prompts are shipped with Toasty Zsh. Please use the promptinit function family to use them.

- toasty : my personal theme, written from scratch, inspired by robby russel's theme.
- [shellder][shellder] : please don't forget to set DEFAULT_USER

#### Provided Plugins ####
The following plugins are shipped with Toasty Zsh. Please use the autosource function to use them.

- sudo : double tap `ESC` to add or remove sudo from your current (or previous, if current is empty) command.
- xterm-title : will print xterm-compatible ascii escapes to change the terminal title to "user@host [currently executing command]" Note: may not work with all terminals (e.g Konsole sets their own titles, which overrides this), but works fine with ones that accept these sequences (e.g st will work just fine).

#### Functions ####
##### AutoSource #####
Will source the first matching file in `$SPATH` (formatted like `$PATH`) for each argument. Think plugins. Subdirectories are valid.

Examples:
```sh
SPATH="$PWD" autosource a # will source ./a if it exists
SPATH="./a:./b" autosource c # will attempt to source ./a/c, and then ./b/c if that fails
SPATH="$PWD" autosource foo/bar # will attempt to source ./foo/bar if it exists
```

##### SourceAll #####
Will source every file under each directory in `$APATH` (formatted like `$PATH`). Will not recurse into subdirectories. If an argument is provided, it will only source files that end in `.$1`.

Examples:
```sh
APATH="a:b" sourceall # will source a/* and b/*
APATH="$PWD" sourceall zsh # will source ./*.zsh
```

##### PVE #####
Manages python virtual environments.

Synopsis: `pve [-p custom_directory] [-d] [-l | -s | venv name]`

This will create and enter a python virtualenv. In its basic form, `pve [venv name]`, it will create it in `~/.venv/[venv name]`.

- `-p directory` : "prefix": use `directory` instead of `~/.venv`.
- `-d` : "delete": instead of creating and entering, delete and exit.
- `-l` : "local": sets "prefix" to the current working directory, and the name to "env".
- `-s` : "self": sets the name to the name of the current working directory.

The last specified flag will be the honored one, getopts style.

Examples:
```sh
pve ipython # create and enter the ipython virtualenv
pve -d ipython # delete the ipython virtualenv. deactivate if you are in one.
pve -p /tmp ipython # create an ipython virtualenv in /tmp
pve -l # create a virtualenv in ./env
pve -s # create a virtualenv in ~/.venv/$PWD
```

##### Sprunge #####
Simple wrapper around uploading text to [sprunge][sprunge]. Takes things in stdin, outputs the url into stdout.

Examples:
```sh
echo hi | sprunge # upload "hi\n" to sprunge.us
sprunge < file # upload file to sprunge.us
bsdtar -cf - --format shar dir | sprunge # upload a "shar" archive of dir to sprunge.us
```

##### toasty-zsh #####
Please don't use this, it's deprecated in favor of `autosource` and `sourceall`.

If you must know what it does, you can look at the completions.

### Disclaimer ###
Some of the provided API may be either written by me (in which case you may consider it ISC code) or shamelessly stolen from somewhere else (in which case you can find the license in `$zshd/third-party-licenses`). Here is the (possibly not up to date) list of files that have partial or full origins elsewhere.

If you want your stuff included, convince me it's useful. Being liberally licensed (preferably not GPL and certainly not GPLv3) should help.

- plugins/sudo : from [omz][omz]
- prompts/toasty : written from scratch, but heavily inspired by the robbyrussel theme from [omz][omz]
- prompts/shellder : taken directly from [shellder][shellder]
- source/bindkeys.zsh : **heavily** inspired by [omz][omz] and [the zsh wiki][zwiki] (whose license I could not find).

### Notes ###
The `shwordsplit` option is handled differently by autosource and sourceall - it will be treated as if the local options setting is set. This is because it's needed for those two functions to work (across more than just zsh), and is therefore set temporarily. However, autosourced and sourcealld files should be able to set options. The compromise is to manually detect its state at the beginning of the source loop, and restore it to that after it is no longer required. The side effect is that you have to set it (if you want it) in `$zd/pre`.

[license]: https://img.shields.io/github/license/5pacetoast/toasty-zsh.svg
[omz]: https://github.com/robbyrussell/oh-my-zsh "Oh-My-Zsh's Repository"
[shellder]: https://github.com/simnalamburt/shellder "Shellder's Home Repository"
[sprunge]: http://sprunge.us/ "A Simple Pastebin Service"
[zwiki]: http://zshwiki.org/home/ "The Zsh Wiki"
