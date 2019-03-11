#!/bin/bash -eu
#PBS -q large
#PBS -T sgimpt
#PBS -b 16 
#PBS -l cpunum_job=28
#PBS -N eq 
#PBS -m ae
#PBS -l elapstim_req=720:00:00

cd $PBS_O_WORKDIR

OMP_NUM_THREADS=1

#cdir=/lfs/mtateno/hnishi/kek9/4thUS/104_3P2D_E/10umbrella/md1
exe_grompp=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/grompp_mpi
exe_mdrun=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/mdrun_mpi
exe_trjconv=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/trjconv_mpi


log=eq1.log2
#$exe_grompp -v -f EQ1.mdp -c min2.gro -p prm.top -o eq1 -r solv_mg_na.gro -po eq1 # -n index.ndx
$exe_grompp -v -f EQ1_NVT.mdp -c min2.gro -p prm.top -o eq1 -r min2.gro -po eq1 # -n index.ndx
#mpijob $exe_mdrun -v -deffnm eq1 -ntomp 12 -nb gpu > $log 2>&1
mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm eq1 > $log 2>&1

log=eq2.log2
$exe_grompp -v -f EQ2_NPT.mdp -c eq1.gro -p prm.top -o eq2 -r min2.gro -po eq2  -t eq1.cpt # -n index.ndx
#mpijob $exe_mdrun -v -deffnm eq2 -ntomp 12 -nb gpu > $log 2>&1
mpirun ${NQSII_MPIOPTS} -np 28  $exe_mdrun -v -deffnm eq2 > $log 2>&1

#mpirun -np 8 mdrun_mpi_d -deffnm md1
#The estimate for PME load will dictate how many processors should be dedicated to the PME calculation, and how many for the PP calculations. Refer to the GROMACS 4 publication and the manual for details. For a cubic box, the optimal setup will have a PME load of 0.25 (3:1 PP:PME - we're in luck!); for a dodecahedral box, the optimal PME load is 0.33 (2:1 PP:PME). When executing mdrun, the program should automatically determine the best number of processors to assign for the PP and PME calculations. Thus, make sure you indicate an appropriate number of nodes for your calculation (the value of -np X), so that you can get the best performance. For this system, I achieved roughly 14 ns/day performance on 24 CPU's (18 PP, 6 PME).
