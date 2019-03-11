#!/bin/bash -eu
#PBS -q small 
#PBS -T sgimpt
#PBS -b 1  
#PBS -l cpunum_job=28
#PBS -N min 
#PBS -m ae
#PBS -l elapstim_req=720:00:00

cd $PBS_O_WORKDIR

OMP_NUM_THREADS=1

#cdir=/lfs/mtateno/hnishi/kek9/4thUS/104_3P2D_E/10umbrella/md1
exe_grompp=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/grompp_mpi
exe_mdrun=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/mdrun_mpi
exe_trjconv=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/trjconv_mpi

log=min1.log2
$exe_grompp -v -f MIN1_posre.mdp -c solv_mg_na.gro -p prm.top -o min1 -r solv_mg_na.gro -po min1_out #-n index.ndx 
#mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm min1 -ntomp 1 > $log 2>&1
mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm min1 > $log 2>&1
#mpijob $exe_mdrun -v -deffnm min1 -ntomp 12 -nb gpu > $log 2>&1

#log=min2.log2
$exe_grompp -v -f MIN2_free.mdp -c min1.gro -p prm.top -o min2 -r min1.gro -po min2_out # -n index.ndx
mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm min2  > $log 2>&1
#mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm min2 -ntomp 1 > $log 2>&1

