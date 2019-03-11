#!/bin/bash -eu

temp_list="conf.list"
cdir=$(pwd)

pre_dir="../02pulling"
#tdir=${cdir}/md1_test
#tdir=${cdir}/md2_test
tdir=${cdir}/md1

mkdir -p $tdir
#template=MD_TEST.mdp.template
template=US1_template.mdp

i=1
for temp in $(cat $temp_list | cut -f 1 -d " ");
do
  echo no${i}, conf: $temp, distance: $(cat conf.list | cut -f 2 -d " "| sed -n ${i}p) nm 
  mkdir -p ${tdir}/no${i}
  touch ${tdir}/no${i}/$(cat conf.list | cut -f 2 -d " "| sed -n ${i}p)nm
  cp $template  ${tdir}/no${i}/MD.mdp
  cp ${pre_dir}/pullconfs/conf${temp}.gro  ${tdir}/no${i}/in.gro
  cp ${pre_dir}/prm.top   ${tdir}/no${i}/
  #sed -e 's;"./amber14sb_parmbsc1.ff;"../../amber14sb_parmbsc1.ff;g' ${pre_dir}/prm.top > ${tdir}/no${i}/prm.top
  cp ${pre_dir}/*.itp   ${tdir}/no${i}/
  cp ${pre_dir}/index.ndx   ${tdir}/no${i}/

  sleep 0.1s
  i=$(($i+1))
done


