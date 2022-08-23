#!/bin/bash
# -z: len = 0 --> true
if [ -z "$1" ] || [ -z "$2" ]
then
    echo "handle_hash.sh <new hash.log> <old hash.log>"
    exit 0
fi

new_hash=$(cat "$1" | grep "Node \[" | awk -F " " '{print($13)}')
old_hash=$(cat "$2" | grep "Node \[" | awk -F " " '{print($13)}')

new_list=(${new_hash//,/ })
old_list=(${old_hash//,/ })
# echo ${new_list[@]} compute count

total_num=$(cat "$2" | grep -c "Node \[")

total_num=35
for i in {1..35}
do
    new_file=./new_kernels/${new_list[$i-1]}.elf
    old_file=./kernels_tmp/${old_list[$i-1]}.elf
    cp $old_file $new_file
    if [ $? -ne 0 ]
    then
        echo $old_file
	echo $new_file
    fi

done



# echo $new_hash 
