#!/bin/bash

#g_wham_mpi -it ./md_tpr_18 -if ./md_pullf_18 -b 50 -v -o profile_raw -hist hist_raw -unit kCal -temp 300 -bins 100 >& wham.log &
#g_wham_mpi -it ../md_tpr -if ../md_pullf -b 100 -v -o profile -hist hist -unit kCal -zprof0 1.222891e+00  >& wham.log &

~/hnishi/sw/gromacs-4.6.6-mpi-s/bin/g_wham_mpi -it ../md_tpr -if ../md_pullf -b 50 -v -o -hist -unit kCal -zprof0 5.0  -temp 300 -bins 100 -nBootstrap 200 -bsres bsResult.xvg -bsprof bsProfs.xvg >& wham.log &

