#!/bin/bash

array=("$@")
copied_array=("${array[@]}")

# echo "The number of arguments passed: $#"
# echo "The arguments passed are: ${array[@]}"
# echo "The arguments passed are: $*"
# echo "The first argument is: $1"
# echo "The second argument is: $2"
# echo "The third argument is: $3"
# echo "The fourth argument is: $4"


for item in "${array[*]}"; do
    echo "Processing item: $item"
done

for item in "$@"; do
    echo "Processing item: $item"
done

echo "Copied array elements:"
for item in "${copied_array[@]}"; do
    echo "Copied item: $item"
done

# associative array
declare -a assoc_array
assoc_array=(
    ["name"]="John Doe"
    ["age"]="30"
    ["city"]="New York"
)

echo "assoc_array[name]: ${assoc_array[name]}"
echo "assoc_array[age]: ${assoc_array[age]}"
echo "assoc_array[city]: ${assoc_array[city]}"

for key in "${!assoc_array[@]}"; do
    echo "Key: $key, Value: ${assoc_array[$key]}"
done