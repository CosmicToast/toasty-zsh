#!/bin/zsh
source ${${(%):-%x}:A:h}/config

if [ ! -d $zshd/zgen ]; then
    git -C "${zshd}" clone https://github.com/tarjoilija/zgen
    echo zgen > "$zshd"/.git/info/exclude
else
    git -C "${zshd}/zgen" pull -q
fi

if [ -r $zshd/pre ]; then; source $zshd/pre; fi

# get zgen to do our stuff
ZGEN_RESET_ON_CHANGE=( ${ZDOTDIR:-$HOME}/.zshrc )
ZGEN_DIR=$zshd/zgen.conf

# zgen
source $zshd/zgen/zgen.zsh

if ! zgen saved; then
	echo "Creating a zgen save."

	zgen oh-my-zsh

	#plugins
	zgen oh-my-zsh plugins/git
	zgen oh-my-zsh plugins/sudo
	zgen oh-my-zsh plugins/extract
	zgen oh-my-zsh plugins/wd
	zgen oh-my-zsh plugins/sprunge
	zgen oh-my-zsh plugins/history-substring-search

	#theme
    zgen load "zenorocha/dracula-theme" zsh/dracula.zsh-theme

	#save
	zgen save
fi

if [ -r $zshd/post ]; then; source $zshd/post; fi
