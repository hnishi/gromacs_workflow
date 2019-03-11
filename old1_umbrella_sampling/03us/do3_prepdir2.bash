#!/bin/bash -eu

temp_list=`pwd -P`/conf.list
cdir=$(pwd)

pre_dir=`pwd -P`/eq1
tdir=${cdir}/md1 
mkdir -p $tdir

p_mdp=`pwd -P`/US1_template.mdp


i=1

for temp in $(cat $temp_list | cut -f 1 -d " ");
do
  echo no${i}, conf: $temp, distance: $(cat conf.list | cut -f 2 -d " " | sed -n ${i}p) nm 
  mkdir -p ${tdir}/no${i}
  touch ${tdir}/no${i}/$(cat conf.list | cut -f 2 -d " " | sed -n ${i}p)nm
  cp $p_mdp  ${tdir}/no${i}/MD.mdp
  cp ${pre_dir}/no${i}/md.gro  ${tdir}/no${i}/in.gro
  cp ${pre_dir}/no${i}/md.cpt  ${tdir}/no${i}/in.cpt
  cp ${pre_dir}/no${i}/prm.top   ${tdir}/no${i}/
  cp ${pre_dir}/no${i}/index.ndx   ${tdir}/no${i}/
  cp ${pre_dir}/no${i}/*.itp   ${tdir}/no${i}/

  sleep 0.1s
  i=$(($i+1))
done

