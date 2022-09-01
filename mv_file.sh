#!/bin/bash

src_hash=
dst_hash=
kernels_path=/home/br104/suinfer/e00310/new_suinfer/suInfer/demo/src/kernel_infer/build/kernels/

if [ -f $1 ]; then
  src_log=$1
  echo "src_log file: ${src_log}"
  src_hash=$(grep "Node \[" ${src_log} | awk '{print $13}')
fi

if [ -f $2 ]; then
  dst_log=$2
  echo "des_log file: ${dst_log}"
  dst_hash=$(grep "Node \[" ${dst_log} | awk '{print $13}')
fi

src_hash_names=(${src_hash//,/})
dst_hash_names=(${dst_hash//,/})

if [ ${#src_hash_names[@]} -ne ${#dst_hash_names[@]} ]; then
  ehco "src kernel cnt not equal to dst kernels cnt, nothing to do !!!"
  exit 0
fi

file_count=${#src_hash_names[@]}

for ((i=0; i<file_count; i++))
do
  if [ ! -f ${kernels_path}${src_hash_names[i]}.elf ];then
    echo "sorry, unexist ${kernels_path}${src_hash_names[i]}"
    exit 0
  fi
done

for ((i=0; i<file_count; i++))
do
  mv ${kernels_path}${src_hash_names[i]}.elf  ${kernels_path}${dst_hash_names[i]}.elf
  echo  mv ${kernels_path}${src_hash_names[i]}.elf to ${kernels_path}${dst_hash_names[i]}.elf successfully!!!
done

echo "run mv_file.sh successfully !!!"
