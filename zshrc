print -Pv zrc %N  # get current file location, store it in $zrc
zrc="$zrc:A"      # resolve $zrc (assume path) to its absolute location
zshd="${zrc:h}"

: "${zd:=$HOME/.zsh}"

# spath -> autosource path, ala plugins
# apath -> sourceall path, for .d dirs
typeset -T SPATH spath
typeset -T APATH apath

# default values
spath=(
    "$zd/plugins"
    "$zshd/plugins"
)
apath=(
    "$zshd/source"
    "$zd/source"
)

# user stuff comes first
# completions come after the functions they complete
fpath+=(
    "$zd/functions"
    "$zd/completions"
    "$zd/prompts"
    "$zshd/functions"
    "$zshd/completions"
    "$zshd/prompts"
)

# sourced before sourcealling
# should be the location to edit fpath/apath/spath
[[ -f "$zd/pre" ]] && . "$zd/pre"

# allow digest drop-in
if [[ -d "$zd/digests" ]]; then
    local f=
    for f in $zd/digests/*.zwc(N); do
        fpath+=( "$f" )
        autoload -w "$f"
    done
fi

autoload sourceall
sourceall zsh # source every .zsh file in every $apath[@] directory

# local zshrc
[[ -f "$zd/zshrc.local" ]] && . "$zd/zshrc.local"

# LITERALLY THE VERY LAST THING WE DO IS COMPINIT PLS DUN DO IT URSELF
autoload -Uz compinit
compinit

# vim: ft=zsh
