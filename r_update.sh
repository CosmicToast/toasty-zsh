#!/bin/sh
# meant to be called by dotfiles, but can be used if you're just lazy

# we need the zcompile built-in
[ -z "$ZSH_VERSION" ] && exec zsh -f $0

zshd="$(dirname $0)"
. "$zshd/functions/toasty-zsh"
toasty-zsh -c
