#!/bin/bash -eu

NAME=do3_cat_mindist.bash

dn_inp1=./
fn_out1=out_do3_mindist.txt

v_str1=""

for i in {1..20}
do
  ls -f ${dn_inp1}/mindist${i}.xvg
  v_str1="${v_str1}${dn_inp1}/mindist${i}.xvg "
done

echo $v_str1
cat $v_str1 |grep -v \#|grep -v @ |uniq > $fn_out1

