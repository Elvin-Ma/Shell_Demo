#!/bin/bash

spc1_dir=$1
spc4_dir=$2

echo spc1_dir : $spc1_dir
echo spc4_dir : $spc4_dir

spc1_files=$(ls ${spc1_dir})
spc4_files=$(ls ${spc4_dir})

spc1_files=(${spc1_files//,/})
spc4_files=(${spc4_files//,/})

spc1_files_cnt=$(ls $spc1_dir | wc -l)
spc4_files_cnt=$(ls $spc4_dir | wc -l)

if [ $spc1_files_cnt -ne $spc4_files_cnt ]; then
  echo "spc1_file_cnt: ${spc1_file_cnt} not equal to spc4_files_cnt: ${spc4_file_cnt}"
  exit 0
fi

for ((i=0; i<$spc1_files_cnt; i++))
do
  # echo ${spc1_files[i]}   ${spc4_files[i]}
  spc1_cycle=$(cat ${spc1_dir}/${spc1_files[i]} | grep cbi_active_cycles_spc | grep spc_id:0 | awk -F "," '{print $NF}' )
  spc4_cycle=$(cat ${spc4_dir}/${spc4_files[i]} | grep cbi_active_cycles_spc | grep spc_id:1, | awk -F "," '{print $NF}' )
  echo ${spc1_files[i]}:$spc1_cycle vs  ${spc4_files[i]}:$spc4_cycle ratio = $(echo "scale=4; ${spc4_cycle} / ${spc1_cycle} " | bc )
done
