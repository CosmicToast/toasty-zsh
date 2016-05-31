zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

zstyle ':completion*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
