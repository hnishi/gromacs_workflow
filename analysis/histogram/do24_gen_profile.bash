#!/bin/bash -eu

NAME="do24_gen_profile.bash";
VERSION=1.0;

echo Program: $NAME  
echo Version: $VERSION  


#awk '{print substr($1,8,4),substr($1,17,4),$2}' out_do12_105.txt |less

#inputfile=3d_out_do21_rg_sasa.dat 
#outputfile=out_do23.dat  

dn_out1=out_do24
bin_width_rg=0.02
bin_width_sasa=0.5
exe_g_analyze=/home/hnishi/local/sw/gromacs-4.6.6-serial/bin/g_analyze_d

rm -r $dn_out1
mkdir -p $dn_out1

for i in 1 2 3 4 6 7
do
  echo $i
  echo Rg
  nl rg_${i}.txt > $dn_out1/rg_${i}.xvg
  $exe_g_analyze -dist $dn_out1/hist_rg_${i} -bw $bin_width_rg -f $dn_out1/rg_${i}.xvg
  echo SASA
  nl sasa_${i}.txt > $dn_out1/sasa_${i}.xvg
  $exe_g_analyze -dist $dn_out1/hist_sasa_${i} -bw $bin_width_sasa -f $dn_out1/sasa_${i}.xvg
done  
