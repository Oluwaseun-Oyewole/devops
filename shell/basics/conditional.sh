#!/bin/bash

if [[ -n "$1" ]]; then
    name="$1"
else
    read -p "Enter your name: " name
    echo "Hello, $name! Welcome to the script."
fi

echo "hello $name"