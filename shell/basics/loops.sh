
# array=("$@")

# for item in "${array[*]}"; do
#     echo "item is $item"
# done 

# i=10

# myFunc(){
#    local i=8;
#     echo "$i"
# }
# myFunc
# # thing=$(myFunc)
# # echo "$thing"
# echo "The real value of I is $i"


# declare -a array=(foo bar baz)
# echo "${#array}"

# x=10

# runner(){
#     x=20;
#     echo "$x"
# }

# run=$(runner)
# echo "$run"
# echo "X value is $x"

. ./lib.sh || exit 1

# while read -r line; do
#     echo "We read line as $line"
# done

echo "You entered thee arguments $@"