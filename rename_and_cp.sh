#!/bin/bash

rm -f 1* 2* 3* 4* 5* 6* 7* 8* 9*

target_dir=/home/br104/suinfer/e00310/suInfer/build/output/kernels/

kernel_type_filter=('Convolution_' 'Convolution_ReLU_' 'Knit_Convolution_ReLU_' 'Add' 'ReLU' 'Pooling' 'Reshape'
                    'Gemm_' 'Softmax')

kernel_type=$1
input_name=$2
kernel_type_full_name=
kernel_names=

if [ ${kernel_type} = "cb" ]; then
  kernel_type_full_name=${kernel_type_filter[0]}
  kernel_names=$(grep "Node \[ Conv_" $2 | awk '{print $13}')
elif [ ${kernel_type} = "cbr" ]; then
  kernel_type_full_name=${kernel_type_filter[1]}
  kernel_names=$(grep "Node \[ " $2 | grep "\[ ${kernel_type_full_name} " | awk '{print $13}')
elif [ ${kernel_type} = "kcbr" ]; then
  kernel_type_full_name=${kernel_type_filter[2]}
  echo "==========kernel_type_full_name: ${kernel_type_full_name}"
  kernel_names=$(grep "Node \[ " $input_name | grep ${kernel_type_full_name} | awk '{print $13}')
elif [ ${kernel_type} = "add" ]; then
  kernel_type_full_name=${kernel_type_filter[3]}
  kernel_names=$(grep "Node \[ " $2 | grep "\[ ${kernel_type_full_name}" | awk '{print $13}')
elif [ ${kernel_type} = "relu" ]; then
  kernel_type_full_name=${kernel_type_filter[4]}
  kernel_names=$(grep "Node \[ " $2 | grep "\[ ${kernel_type_full_name}" | awk '{print $13}')
elif [ ${kernel_type} = "pool" ]; then
  kernel_type_full_name=${kernel_type_filter[5]}
  kernel_names=$(grep "Node \[ " $2 | grep "\[ ${kernel_type_full_name}" | awk '{print $13}')
elif [ ${kernel_type} = "reshape" ]; then
  kernel_type_full_name=${kernel_type_filter[6]}
  kernel_names=$(grep "Node \[ " $2 | grep "\[ ${kernel_type_full_name}" | awk '{print $13}')
elif [ ${kernel_type} = "gemm" ]; then
  kernel_type_full_name=${kernel_type_filter[7]}
  kernel_names=$(grep "Node \[ $kernel_type_full_name" $2 | awk '{print $12}')
elif [ ${kernel_type} = "softmax" ]; then
  kernel_type_full_name=${kernel_type_filter[8]}
  kernel_names=$(grep "Node \[ " $2 | grep "\[ ${kernel_type_full_name}" | awk '{print $13}')
else
  echo "FAILED to recognize op type !!!"
fi

echo "kernel_type_full_name: ${kernel_type_full_name}"

#echo $kernel_names
sulib_sample_cnt=$(ls -l suinfer_kernel_0000* | wc -l)
kernel_names_cnt=(${kernel_names//,/ })
if [ $sulib_sample_cnt -ne ${#kernel_names_cnt[@]} ]; then
  echo "sulib sample count: ${sulib_sample_cnt} not equal to log needed kernel count: ${kernel_names_cnt} !!!"
  exit 0
fi

cnt=0
for kn in ${kernel_names}; do
  echo line 40: mv suinfer_kernel_0000${cnt}.elf to ${kn}.elf successfully
  mv suinfer_kernel_0000${cnt}.elf ${kn}.elf
  echo line 42: cp ${kn}.elf to ${target_dir} successfully
  cp ${kn}.elf ${target_dir}
  cnt=$((cnt+1))
done
