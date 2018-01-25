#!/bin/bash -eu

#grompp_mpi_d -f IONS.mdp -c solv.gro -p topol.top -o ions.tpr
#genion_mpi_d -s ions.tpr -o solv_ions.gro -p topol.top -pname NA -nname CL -neutral -conc 0.1

#gmx grompp -f IONS.mdp -c solv.gro -p prm.top -o ions_mg.tpr
#gmx genion -s ions_mg.tpr -o solv_mg.gro -p prm.top -pname MG -nname CL -neutral -conc 0.01 <<< "SOL"

#gmx grompp -f IONS.mdp -c solv_mg.gro -p prm.top -o ions_mg_na.tpr
#gmx genion -s ions_mg_na.tpr -o solv_mg_na.gro -p prm.top -pname NA -nname CL -conc 0.15 <<< "SOL"

#grompp_d -f IONS.mdp -c solv.gro -p prm.top -o ions_mg.tpr
#genion -s ions_mg.tpr -o solv_mg.gro -p prm.top -pname MG -nname CL -neutral -conc 0.01 <<< "SOL"
#genion_d -s ions_mg.tpr -o solv_mg.gro -p prm.top -pname MG -pq 2 -np 128 <<< "SOL"

#grompp_d -f IONS.mdp -c solv_mg.gro -p prm.top -o ions_mg_na.tpr
#genion -s ions_mg_na.tpr -o solv_mg_na.gro -p prm.top -pname NA -nname CL -conc 0.15 <<< "SOL"
#genion_d -s ions_mg_na.tpr -o solv_mg_na.gro -p prm.top -pname NA -nname CL -neutral -conc 0.15 <<< "SOL"

#We are going to be conducting these simulations in the presence of 100 mM NaCl, on top of neutralizing counterions



grompp_d -f IONS.mdp -c solv.gro -p prm.top -o ions_na.tpr
genion_d -s ions_na.tpr -o solv_na.gro -p prm.top -pname NA -pq 1 -nname CL -nq -1 -conc 0.15 -neutral <<< "SOL"

grompp_d -f IONS.mdp -c solv_na.gro -p prm.top -o ions_na_mg.tpr
genion_d -s ions_na_mg.tpr -o solv_na_mg.gro -p prm.top -pname MG -pq 2 -nname CL -nq -1 -neutral -conc 0.025 <<< "SOL" #-np 128

