#!/bin/zsh
. ${${(%):-%x}:A:h}/config

# run us first!
# ... mostly legacy, needed?
[ -r $zd/pre ] && . $zd/pre

# --- fpath stuff ---
# user stuff comes first
# completions come after the functions they complete
local fdirs=(
    $zd/functions
    $zd/completions
    $zd/prompts
    $zshd/functions
    $zshd/completions
    $zshd/prompts
)
for fdir in $fdirs; do
    fpath=($fpath $fdir)
done

# source stuff
unsetopt NOMATCH
for f in $zshd/source/*.zsh
do
    [ -r $f ] && . $f
done
setopt NOMATCH

# source user stuff
unsetopt NOMATCH #don't report an error if no rc files are found
if [ -d $zd -a -d $zd/source ]; then
    for f in $zd/source/*.zsh
    do
        [ -r $f ] && . $f
    done
fi
setopt NOMATCH

# local zshrc
if [ -r $zd/zshrc.local ]; then
    . $zd/zshrc.local
elif [ -r ${ZDOTDIR:-$HOME}/.zshrc.local ]; then
    . ${ZDOTDIR:-$HOME}/.zshrc.local
elif [ -r ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi

# LITERALLY THE VERY LAST THING WE DO IS COMPINIT PLS DUN DO IT URSELF
autoload -Uz compinit
compinit

# vim: ft=zsh
