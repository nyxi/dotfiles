export PS1="\[\033[0;32m\](\[\033[1;37m\]\\u\[\033[1;33m\]@\[\033[1;37m\]\\h\[\033[0;32m\]) \[\033[1;37m\]\\W\[\033[0;32m\] \$ \[\033[0;38m\]"
eval $(dircolors .dir_colors)
alias ls='ls --color=auto'
alias mip="ifconfig | grep 'inet addr' | grep -v '127.0.0.1' | sed -e 's/^.*addr://g' -e 's/ .*//g'"
alias mount="mount | column -t"
alias mkdir="mkdir -pv"
[[ $- != *i* ]] && return
[[ "$PS1" ]] && fortune linux
