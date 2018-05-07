#!/bin/bash -eu

NAME=do_trjcat.bash
VERSION=1.1

dn_inp1=.
fn_out1=md_200ns_per200ps.xtc
fn_log1=log_trjcat.txt
per_ps=200


v_str1=""

for i in {11..20}
do
  ls -f ${dn_inp1}/md${i}.xtc
  v_str1="${v_str1}${dn_inp1}/md${i}.xtc "
done

echo $v_str1

trjcat_d -f $v_str1 -dt $per_ps -o $fn_out1 > $fn_log1 2>&1 &
