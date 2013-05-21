export PS1="\[\033[0;32m\](\[\033[1;37m\]\\u\[\033[1;33m\]@\[\033[1;37m\]\\h\[\033[0;32m\]) \[\033[1;37m\]\\W\[\033[0;32m\] \$ \[\033[0;38m\]"
eval $(dircolors ~/.dir_colors)

#################
#   FUNCTIONS   #
#################
ifroot() {
	if [ "$(whoami)" == "root" ]; then
		$1
	else
		lulz="sudo $1"
		eval $lulz
	fi
}

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
	ifroot "python -m SimpleHTTPServer 80"
}

syncbrc() {
	curl -so ~/.bashrc https://raw.github.com/nyxi/dotfiles/master/.bashrc && echo "Updated ~/.bashrc from github"
}

upgrade() {
	if [ "$(whoami)" == "root" ]; then
		apt-get update && apt-get upgrade && apt-get clean
	else
		sudo apt-get update && sudo apt-get upgrade && sudo apt-get clean
	fi
}

wlscan() {
	if [ "$1" != "" ]; then
		ifroot "iwlist $1 scan | grep "ESSID:" | sed -e 's/ //g' -e 's/ESSID:\"//g' -e 's/\"//g' | sort -u"
	else
		echo "Must provide name of interface to scan"
	fi
}

wlsetup() {
	if [ "$1" != "" ] && [ "$2" != "" ]; then
		wpaconf="$(mktemp)"
		wpa_passphrase "$1" "$2" > $wpaconf 2> /dev/null
		echo "Running wpa_supplicant.."
		ifroot "wpa_supplicant -B -i wlan0 -c $wpaconf 2> /dev/null"
		echo "Waiting 3s before running dhclient.."
		sleep 3
		echo "Running dhclient.."
		ifroot "dhclient wlan0"
	else
		echo "Usage: wlsetup nameofnetwork password"
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
