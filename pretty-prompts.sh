#!/bin/bash

set_prompt(){
	local colors
	colors=( $1 )
	
        PS1="\[\e]0;\u@\h: \w\a\]"
	PS1+="\[\e[0;38;5;${colors[0]}m\]\u"
	PS1+="\[\e[0;38;5;${colors[1]}m\]@"
	PS1+="\[\e[0;38;5;${colors[2]}m\]\h"
	PS1+="\[\e[0;38;5;${colors[3]}m\] "
	PS1+="\[\e[0;38;5;${colors[4]}m\]\w"
	PS1+="\[\e[0;38;5;${colors[5]}m\]\\\$"
        PS1+="\[\e[0m\] "
}

main(){
	if [[ -n "$1" ]]; then
		ID="$1"
	fi
	if [[ "$ID" == "--auto" ]]; then
		unset ID
	fi
	if [[ "$TERM" == "xterm" && "$SHELL" == "/bin/bash" ]] ; then

		if [[ -z "$ID" ]]; then
			. /etc/os-release
		fi

		case "$ID" in
			ubuntu)		colors="202 241 230 090 127 255" ;;
			void)		colors="036 255 114 255 113 255" ;;
			*)		colors="227 221 215 209 203 197" ;;
		esac
		set_prompt "$colors"
	else
		PS1='\u@\h \w\$ '
	fi
}

main "$@"

