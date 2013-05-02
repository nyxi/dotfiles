export PS1="\[\033[0;32m\](\[\033[1;37m\]\\u\[\033[1;33m\]@\[\033[1;37m\]\\h\[\033[0;32m\]) \[\033[1;37m\]\\W\[\033[0;32m\] \$ \[\033[0;38m\]"
eval $(dircolors ~/.dir_colors)

#################
#   FUNCTIONS   #
#################
authme() {
	ssh "$1" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' \
	< ~/.ssh/id_rsa.pub
}

iip() {
	ip a | grep "inet " | sed -e 's/^.*inet //g' -e 's/\/.*//g' | grep -v '127.0.0.1'
}

genpw() { tr -dc 'A-Za-z0-9!@#$%^&*' < /dev/urandom | fold -w 12 | head -n 1; }

lo() { $1 & > /dev/null  2>&1; }

servedir() {
	if [ "$(whoami)" == "root" ]; then
		python -m SimpleHTTPServer 80
	else
		sudo python -m SimpleHTTPServer 80
	fi
}

upgrade() {
	if [ "$(whoami)" == "root" ]; then
		apt-get update && apt-get upgrade && apt-get clean
	else
		sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean
	fi
}


###############
#   ALIASES   #
###############
alias confcat="sed -e 's/[#;].*//;/^\s*$/d' "$@""
alias l.='ls -d "$1".* --color=auto'
alias ls='ls --color=auto'
alias eip="echo "$(curl -s http://nyxi.eu/ip.php)""
alias mkdir="mkdir -pv"
alias mm="sshfs -o idmap=user root@hem.nyxi.eu:/mnt/nas/Musik ~/Music"
alias mount="mount | column -t"
alias mpc="mpc -f '%position%. %artist% - %title%'"
alias mpd="mpd && mpdas -d"
alias um="fusermount -u ~/Music"


###############
#   FORTUNE   #
###############
[[ $- != *i* ]] && return
[[ "$PS1" ]] && if [ "$(which fortune)" != "" ]; then fortune linux; fi
