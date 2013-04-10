export PS1="\[\033[0;32m\](\[\033[1;37m\]\\u\[\033[1;33m\]@\[\033[1;37m\]\\h\[\033[0;32m\]) \[\033[1;37m\]\\W\[\033[0;32m\] \$ \[\033[0;38m\]"
eval $(dircolors .dir_colors)
alias ls='ls --color=auto'
alias mip="ifconfig | grep 'inet addr' | grep -v '127.0.0.1' | sed -e 's/^.*addr://g' -e 's/ .*//g'"
alias eip="echo "$(curl -s http://nyxi.eu/ip.php)""
alias mount="mount | column -t"
alias mkdir="mkdir -pv"
alias mm="sshfs -o idmap=user root@hem.nyxi.eu:/mnt/nas/Musik ~/Music"
alias um="fusermount -u ~/Music"
[[ $- != *i* ]] && return
[[ "$PS1" ]] && fortune linux
