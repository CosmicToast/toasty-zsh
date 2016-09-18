#!/bin/sh
# meant to be called by dotfiles, but can be used if you're just lazy

# if we're not running zsh, we want to exec into it
# we need zsh for zcompile
if [ -z "$ZSH_VERSION" ]
then
    z="$(grep /etc/shells -e zsh | head -1)"
    if [ -z "$z" ]
    then
        echo "Could not find a usable zsh installation!"
        exit 1
    else
        exec "$z" -f "$0"
    fi
fi

zshd="$(dirname $0)"
. "$zshd/functions/toasty-zsh"
toasty-zsh -c
