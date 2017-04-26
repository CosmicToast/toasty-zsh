# this should only be used as the zshrc, so this is fine
zrc="$HOME/.zshrc"
zrc="$zrc:A"
. "$zrc:h/config"

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
[ -f "$zd/pre" ] && . "$zd/pre"

autoload sourceall
sourceall zsh # source every .zsh file in every $apath[@] directory

# local zshrc
[ -f "$zd/zshrc.local" ] && . "$zd/zshrc.local"

# LITERALLY THE VERY LAST THING WE DO IS COMPINIT PLS DUN DO IT URSELF
autoload -Uz compinit
compinit

# vim: ft=zsh
