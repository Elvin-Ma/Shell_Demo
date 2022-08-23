#!/bin/bash

str0="cat"
str2=".jpg"
for i in {20..64}
do
  str1=$i 
  echo "i is : "
  echo $str1
  str3="$str0$str1$str2"

  echo $str3
  cp cat.jpg $str3
done
