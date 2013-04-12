export PS1="\[\033[0;32m\](\[\033[1;37m\]\\u\[\033[1;33m\]@\[\033[1;37m\]\\h\[\033[0;32m\]) \[\033[1;37m\]\\W\[\033[0;32m\] \$ \[\033[0;38m\]"
eval $(dircolors .dir_colors)
authme() {
	ssh "$1" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' \
	< ~/.ssh/id_rsa.pub
}
alias confcat="sed -e 's/[#;].*//;/^\s*$/d' "$@""
alias ls='ls --color=auto'
iip() {
	cmd="ifconfig | grep 'inet addr' | grep -v '127.0.0.1' | sed -e 's/^.*addr://g' -e 's/ .*//g'"
	if [ "$(whoami)" == "root" ]; then
		$cmd
	else
		sudo $cmd
	fi
}
alias eip="echo "$(curl -s http://nyxi.eu/ip.php)""
alias mkdir="mkdir -pv"
alias mm="sshfs -o idmap=user root@hem.nyxi.eu:/mnt/nas/Musik ~/Music"
alias mount="mount | column -t"
alias mpc="mpc -f '%position%. %artist% - %title%'"
servedir(){
    sudo python -m SimpleHTTPServer 80
}
alias um="fusermount -u ~/Music"
upgrade() {
	if [ "$(whoami)" == "root" ]; then
		apt-get update && apt-get upgrade && apt-get clean
	else
		sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean
	fi
}
[[ $- != *i* ]] && return
[[ "$PS1" ]] && if [ "$(which fortune)" != "" ]; then fortune linux; fi
