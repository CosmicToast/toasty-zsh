# example on how to print current running task to the terminal title
# part 2: using the function

autoload -Uz add-zsh-hook
add-zsh-hook precmd  xterm-title
add-zsh-hook preexec xterm-title
add-zsh-hook chpwd   xterm-title

# vim: ft=zsh
