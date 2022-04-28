#!/bin/sh

__colors () {
    case "$os_family" in
        ubuntu)     colors=(202 241 230 090 127 255) ;;
        void)       colors=(036 255 114 255 113 255) ;;
        centos)     colors=(214 018 112 255 090 255) ;;
        fedora)     colors=(025 244 255 255 027 255) ;;
        Linux)      colors=(220 243 220 243 220 255) ;;
        gentoo)     colors=(104 189 146 254 104 254) ;;
        Darwin)     colors=(75 69 111 75 195 15) ;;
        *)          colors=(227 221 215 209 203 197) ;;
    esac
}

__bash_prompt () {
    PS1="\[\e]0;\u@\h: \w\a\]"
    PS1+="\[\e[0;38;5;$1m\]\u"
    PS1+="\[\e[0;38;5;$2m\]@"
    PS1+="\[\e[0;38;5;$3m\]\h"
    PS1+="\[\e[0;38;5;$4m\] "
    PS1+="\[\e[0;38;5;$5m\]\w"
    PS1+="\[\e[0;38;5;$6m\]\\\$"
    PS1+="\[\e[0m\] "
}

__zsh_prompt () {
    autoload -U colors && colors
    PS1=""
    PS1+="%F{$1}%n"
    PS1+="%F{$2}@"
    PS1+="%F{$3}%m"
    PS1+="%F{$4} "
    PS1+="%F{$5}%1~"
    PS1+="%F{$6}%#"
    PS1+="%F{reset} "
}

__os_release () {
    source /etc/os-release
    echo "$ID"
}

__os_family () {
    if [ -n "$1" ]; then
        os_family="$1"
    else
        if [ -e /etc/os-release ]; then
            read -r os_family < <(__os_release)
        else
            read -r os_family < <(uname)
        fi
    fi
}

if [ -n "$PS1" ] && [ "${TERM:0:5}" = "xterm" ]
then
    __os_family
    __colors 

    [ -n "$ZSH_VERSION" ] && __zsh_prompt "${colors[@]}"
    [ -n "$BASH_VERSION" ] && __bash_prompt "${colors[@]}"

fi

unset -f __zsh_prompt __bash_prompt __colors __os_release __os_family
unset os_family

