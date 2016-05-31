# this is totally not shamelessly stolen from omz-keybindings and zshwiki
# definitely not
# no way

# basic bindings
bindkey ${terminfo[khome]} beginning-of-line
bindkey ${terminfo[kend]}  end-of-line

bindkey ${terminfo[kdch1]} delete-char

bindkey ${terminfo[kcuu1]} up-line-or-history
bindkey ${terminfo[kcud1]} down-line-or-history

bindkey ${terminfo[kcub1]} backward-char
bindkey ${terminfo[kcuf1]} forward-char

bindkey '^?'               backward-delete-char
bindkey ${terminfo[kdch1]} delete-char

# opinionated bindings
bindkey '^r'              history-incremental-search-backward
bindkey '^[[1;5C'         forward-word
bindkey '^[[1;5D'         backward-word
bindkey ${terminfo[kcbt]} reverse-menu-complete

# make sure terminfo keys make actual sense
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
