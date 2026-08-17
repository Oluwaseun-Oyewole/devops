#!/bin/bash

greetings(){
    s=$1
   echo "Hello, $s! Welcome!"
}

goodbye(){
    s=$1
    echo "Goodbye, $s! See you next time."
}


if ! (return 2>/dev/null); then
    greetings "Seun"
    goodbye "Samuel"
fi
