#!/bin/bash -eu
#PBS -q small 
#PBS -T sgimpt
#PBS -b 1
#PBS -l cpunum_job=28
#PBS -N kek4_96_5_2   
#PBS -m ae
#PBS -l elapstim_req=720:00:00

cd $PBS_O_WORKDIR

exe_grompp=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/grompp_mpi
exe_mdrun=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/mdrun_mpi
exe_trjconv=/home/mtateno/hnishi/sw/gromacs-4.6.6-mpi-s/bin/trjconv_mpi

$exe_grompp -v -f MD1_PULL.mdp -c eq2.gro -p prm.top -n index.ndx -o md1 -t eq2.cpt -r min2.gro
mpirun ${NQSII_MPIOPTS} -np 28 $exe_mdrun -v -deffnm md1 -px md1_pullx.xvg -pf md1_pullf.xvg


awk '{if($1==i){print $1/2,$3;i=i+2}}' md1_pullx.xvg > summary_z.dat

mkdir -p ./pullconfs
cd ./pullconfs
$exe_trjconv -s ../md1.tpr -f ../md1.xtc -o conf.gro -sep <<< 'System'
#perl ../distances.pl
cd ..



#grompp_mpi_d -f MD1_PULL.mdp -c eq1_npt.gro -p topol.top -n index.ndx -t eq1_npt.cpt -o md1_pull.tpr
#mpirun -np 8 mdrun_mpi_d -deffnm md1_pull -px md1_pullx.xvg -pf  md1_pullf.xvg

#mpirun -np 8 mdrun_mpi_d -deffnm md1

#The estimate for PME load will dictate how many processors should be dedicated to the PME calculation, and how many for the PP calculations. Refer to the GROMACS 4 publication and the manual for details. For a cubic box, the optimal setup will have a PME load of 0.25 (3:1 PP:PME - we're in luck!); for a dodecahedral box, the optimal PME load is 0.33 (2:1 PP:PME). When executing mdrun, the program should automatically determine the best number of processors to assign for the PP and PME calculations. Thus, make sure you indicate an appropriate number of nodes for your calculation (the value of -np X), so that you can get the best performance. For this system, I achieved roughly 14 ns/day performance on 24 CPU's (18 PP, 6 PME).
