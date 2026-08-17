#!/bin/bash

greetings(){
    s=$1
   echo "Hello, $s! Welcome!"
}

goodbye(){
    s=$1
    echo "Goodbye, $s! See you next time."
}

if (($# == 0)); then
        echo "Argument required!!" >&2
        exit 1
fi

for name in "$@"; do
    if [[ $name = d* ]]; then
        echo "Hello, $name! Welcome to the script. Special greeting for names starting with 'd'."
    elif [[ $name = a* ]]; then
        echo "Hello, $name! Welcome to the script. Special greeting for names starting with 'a'."
    else
        echo "Goodbye, $name! See you next time."
    fi
done


for name in "$1"; do 
    case $name in
        d*)
            greetings "$name"
            ;;
        a*)
            greetings "$name"
            ;;
        *)
            goodbye "$name"
            ;;
    esac
done