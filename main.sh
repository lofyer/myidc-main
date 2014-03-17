#!/bin/bash
main () {
	echo -en '\E[37;33m'"\033[1mMyIDC - Emulate Scripts\n\033[0m"
	echo -e '**************Base System**************'
	echo -e '1) Setup Base Cluster System(kvm)'
	echo -e '2) Setup Base Cluster System(xen)'
	echo -e '*************Control Panel*************'
	echo -e '3) Setup Nested Cloud Platform'
	echo -e '****************VM Cloud***************'
	echo -e '4) Setup Control Panel on http://localhost:80'
	echo -e 'Choose(1-4): '

	while true
	do
		read -s -n 1 answer_option
		case $answer_option in
			1) echo "123";;
			*) continue;;
		esac
		break
	done

	echo "345"
}

clear
main
