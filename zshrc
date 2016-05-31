#!/bin/zsh
source ${${(%):-%x}:A:h}/config

# run us first!
if [ -d $zd -a -r $zd/pre ]; then source $zd/pre; fi


# --- SYSTEM ---
# prepackaged functions
fpath+=$zshd/functions
# prepackaged prompts
fpath+=$zshd/prompts

# source stuff
unsetopt NOMATCH
for f in $zshd/source/*.zsh
do
    [ -r $f ] && source $f
done
setopt NOMATCH


# --- USER ---
# user's own functions
fpath+=$zd/functions
# user's prompts
fpath+=$zd/prompts
# user's uh... stuff?
fpath+=$zd

# user zsh.d
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
