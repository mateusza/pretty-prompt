#!/bin/bash

main() {
    local hex
    hex="0369cf"

    local color r g b
    local hexcolor textcolor
    for ((r=0; r<6; r++))
    do
        for ((g=0; g<6; g++))
        do
            for ((b=0; b<6; b++))
            do
                ((color = b + 6 * g + 36 * r + 16))
                hexcolor="${hex:r:1}${hex:g:1}${hex:b:1}"
                ((textcolor = (r>2 || g>2 || b>2) ? 0 : 15))
                printf "\e[0;48;5;%d;38;5;%dm %3d #%s \e[0m" "$color" "$textcolor" "$color" "$hexcolor"
            done
            printf "\n"
        done
        printf " \n"
    done
}

main
