#!/bin/bash -eu
#PBS -q large
#PBS -T sgimpt
#PBS -b 16 
#PBS -l cpunum_job=28
#PBS -N smd
#PBS -m ae
#PBS -l elapstim_req=720:00:00

cd $PBS_O_WORKDIR

OMP_NUM_THREADS=1

#cdir=/lfs/mtateno/hnishi/kek9/4thUS/104_3P2D_E/10umbrella/md1
exe_grompp=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/grompp_mpi
exe_mdrun=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/mdrun_mpi
exe_trjconv=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/trjconv_mpi

#log=min1.log2
#$exe_grompp -v -f MIN1_freeze.mdp -c solv_mg_na.gro -p prm.top -o min1 -r solv_mg_na.gro -po min1 -n index.ndx
#mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm min1 -ntomp 1 > $log 2>&1

#log=eq1.log2
#$exe_grompp -v -f EQ1.mdp -c min1.gro -p prm.top -o eq1 -r solv_mg_na.gro -po eq1  -n index.ndx
#mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm eq1 > $log 2>&1

#log=eq2.log2
#$exe_grompp -v -f EQ2.mdp -c eq1.gro -p prm.top -o eq2 -r solv_mg_na.gro -po eq2  -t eq1.cpt  -n index.ndx
#mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm eq2 > $log 2>&1

log=smd1.log2
$exe_grompp -v -f SMD1_PULL.mdp -c ./eq2.gro -t ./eq2.cpt -p ./prm.top -o smd1 -r ./min2.gro  -po smd1_out  -n ./index.ndx
mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm smd1 -pf smd1_pullf.xvg -px smd1_pullx.xvg > $log 2>&1

awk '{if($1==i){print $1/2,$3;i=i+2}}' smd1_pullx.xvg > summary_z.dat

mkdir -p ./pullconfs
cd ./pullconfs
  $exe_trjconv -s ../smd1.tpr -f ../smd1.xtc -o conf.gro -sep <<< 'System'
cd ..

