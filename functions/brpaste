#!/bin/zsh
host='https://brpaste.xyz'
[[ $# -eq 0 ]] && set -- '-'
brpaste_id=$(curl -\#fF "data=<$1" "$host") \
    || { echo 'ERROR: Upload failed!' >&2 && return 1; }
printf '%s/%s\n' "$host" "$brpaste_id"
