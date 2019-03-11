#!/bin/bash -eu
#PBS -q large
#PBS -T sgimpt
#PBS -b 16 
#PBS -l cpunum_job=28
#PBS -N md1
#PBS -m ae
#PBS -l elapstim_req=720:00:00

cd $PBS_O_WORKDIR

OMP_NUM_THREADS=1

#cdir=/lfs/mtateno/hnishi/kek9/4thUS/104_3P2D_E/10umbrella/md1
exe_grompp=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/grompp_mpi
exe_mdrun=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/mdrun_mpi
exe_trjconv=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/trjconv_mpi


log=md1.log2
#$exe_grompp -v -f EQ1.mdp -c min2.gro -p prm.top -o eq1 -r solv_mg_na.gro -po eq1 # -n index.ndx
$exe_grompp -v -f  MD1_2ns_free.mdp -c eq2.gro -p prm.top -o md1 -po md1_out # -n index.ndx
#mpijob $exe_mdrun -v -deffnm eq1 -ntomp 12 -nb gpu > $log 2>&1
mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm md1 > $log 2>&1

