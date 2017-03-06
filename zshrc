# this should only be used as the zshrc, so this is fine
zrc="$HOME/.zshrc"
zrc="$zrc:A"
. "$zrc:h/config"

# run us first!
# ... mostly legacy, needed?
[ -r $zd/pre ] && . $zd/pre
# options treated separately because of sourceall
[ -f "$zshd/options.zsh" ] && . "$zshd/options.zsh"
[ -f "$zd/options.zsh"   ] && . "$zd/options.zsh"

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

autoload autosource
typeset -T SPATH spath
spath=(
    "$zd/plugins"
    "$zshd/plugins"
)

autoload sourceall
typeset -T APATH apath
apath=(
    "$zd/source"
    "$zshd/source"
)
sourceall

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
