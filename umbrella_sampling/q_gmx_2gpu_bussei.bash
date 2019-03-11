#!/bin/bash -eu

#QSUB -queue F18acc
#QSUB -node 2
#QSUB -mpi 4
#QSUB -omp 12
#QSUB -place pack
#QSUB -over false
#PBS -l walltime=24:00:00
#PBS -N ubXXX  
###PBS -j oe
###PBS -W depend=afterok:1267800
cd ${PBS_O_WORKDIR}

#. /etc/profile.d/modules.sh
#module load intel/15.0.3.187 mpt/2.12
#mpijob /home/k0072/k007200/amber12/bin/sander.MPI -O -ng 16 -groupfile grp.SB

export MPI_IB_RAILS=2

#/home/k0072/k007200/gromacs4.6.6/bin/grompp_mpi_d  -f MD1.mdp -c eq2.gro -p prm.top -o md1.tpr -t eq2.cpt > grompp.log 2>&1
#mpijob /home/k0072/k007200/hnishi/sw/gromacs-4.6.6-gpu/bin/mdrun_mpi -v -deffnm md1 -cpi eq2.cpt -ntomp 12 -nb gpu > md1.log2 2>&1
#mpijob /home/k0072/k007200/hnishi/sw/gromacs-4.6.6-gpu/bin/mdrun_mpi -v -deffnm md -cpi eq2.cpt -nsteps 10000000 -ntomp 12 -nb gpu > md.log2 2>&1

exe_grompp=/home/k0072/k007200/hnishi/sw/gromacs-4.6.6-gpu/bin/grompp_mpi
exe_mdrun=/home/k0072/k007200/hnishi/sw/gromacs-4.6.6-gpu/bin/mdrun_mpi
#exe_trjconv=/home/k0072/k007200/hnishi/sw/gromacs-4.6.6-gpu/bin/trjconv_mpi

#$exe_grompp -v -f MD1_PULL.mdp -c eq2.gro -p prm.top -n index.ndx -o md1 -t eq2.cpt -r min2.gro
#mpijob $exe_mdrun -v -deffnm md1 -ntomp 12 -nb gpu > md1.log2 2>&1
#mpirun ${NQSII_MPIOPTS} -np 28 $exe_mdrun -v -deffnm md1 -px md1_pullx.xvg -pf md1_pullf.xvg

#$exe_grompp -v -f SMD1_PULL.mdp -c eq2.gro -p prm.top -o smd1 -r min2.gro -po smd1 -t eq2.cpt -n index.ndx
#mpijob $exe_mdrun -v -deffnm smd1 -px smd1_pullx.xvg -pf  smd1_pullf.xvg -ntomp 12 -nb gpu > smd1.log2 2>&1

mpijob $exe_mdrun -v -deffnm md -px md_pullx.xvg -pf  md_pullf.xvg -ntomp 12 -nb gpu > md.log2 2>&1


#awk '{if($1==i){print $1/2,$3;i=i+2}}' smd1_pullx.xvg > summary_z.dat

#mkdir -p ./pullconfs
#cd ./pullconfs
#trjconv_mpi -s ../md1.tpr -f ../md1.xtc -o conf.gro -sep <<< 'System'
#perl ../distances.pl
#cd ..



#grompp_mpi_d -f MD1_PULL.mdp -c eq1_npt.gro -p topol.top -n index.ndx -t eq1_npt.cpt -o md1_pull.tpr
#mpirun -np 8 mdrun_mpi_d -deffnm md1_pull -px md1_pullx.xvg -pf  md1_pullf.xvg

#mpirun -np 8 mdrun_mpi_d -deffnm md1

#The estimate for PME load will dictate how many processors should be dedicated to the PME calculation, and how many for the PP calculations. Refer to the GROMACS 4 publication and the manual for details. For a cubic box, the optimal setup will have a PME load of 0.25 (3:1 PP:PME - we're in luck!); for a dodecahedral box, the optimal PME load is 0.33 (2:1 PP:PME). When executing mdrun, the program should automatically determine the best number of processors to assign for the PP and PME calculations. Thus, make sure you indicate an appropriate number of nodes for your calculation (the value of -np X), so that you can get the best performance. For this system, I achieved roughly 14 ns/day performance on 24 CPU's (18 PP, 6 PME).
