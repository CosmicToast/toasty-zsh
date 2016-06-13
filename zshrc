#!/bin/zsh
source ${${(%):-%x}:A:h}/config

# run us first!
# ... mostly legacy, needed?
if [ -d $zd -a -r $zd/pre ]; then source $zd/pre; fi

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
    [ -r $f ] && source $f
done
setopt NOMATCH

# source user stuff
unsetopt NOMATCH #don't report an error if no rc files are found
if [ -d $zd -a -d $zd/source ]; then
    for f in $zd/source/*.zsh
    do
        [ -r $f ] && source $f
    done
fi
setopt NOMATCH

# local zshrc
if [ -d $zd -a -r $zd/zshrc.local ]; then
    source $zd/zshrc.local
elif [ -r ${ZDOTDIR:-$HOME}/.zshrc.local ]; then
    source ${ZDOTDIR:-$HOME}/.zshrc.local
elif [ -r ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

# LITERALLY THE VERY LAST THING WE DO IS COMPINIT PLS DUN DO IT URSELF
autoload -Uz compinit
compinit
