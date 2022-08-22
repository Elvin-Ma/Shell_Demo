#!/bash/bin

file_names=`ls | grep onnx | awk '{print $NF}'`
new_file_names=`ls | grep onnx | awk -F :: '{print $NF}'`
#echo $new_file_name
#echo $file_name
old_file=(${file_names//,/ })
new_file=(${new_file_names//,/ })

echo "==== ${#old_file[@]}"
file_count=${#old_file[@]}
echo "*****$file_count"
i=0
while [ $i -lt ${file_count} ];
do
  old_file=${old_file[$i-1]}
  new_file=${new_file[$i-1]}
  echo "$old_file   $new_file"
  #echo "$old_file rename to $new_file"
  `mv ${old_file} ${new_file}`
  i=$(($i+1))
done
