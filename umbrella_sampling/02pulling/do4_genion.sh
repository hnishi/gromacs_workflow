#!/bin/bash -eu

#sed -e 's;./amber14sb_parmbsc1.ff;../../amber14sb_parmbsc1.ff;g' prm.top_solv >  prm.top

cp prm.top_solv   prm.top

grompp_d -f IONS.mdp -c solv.gro -p prm.top -o ions_mg.tpr -po ions_mg.mdp
genion_d -s ions_mg.tpr -o solv_mg.gro -p prm.top -pname MG -pq 2 -np 10 <<< "SOL"

grompp_d -f IONS.mdp -c solv_mg.gro -p prm.top -o ions_mg_na.tpr -po ions_mg_na.mdp
genion_d -s ions_mg_na.tpr -o solv_mg_na.gro -p prm.top -pname NA -pq 1 -np 226 -nname CL -neutral <<< "SOL"


#grompp_d -f IONS.mdp -c solv.gro -p prm.top -o ions_na.tpr
#genion_d -s ions_na.tpr -o solv_na.gro -p prm.top -pname NA -pq 1 -np 226 -nname CL -nq -1 -neutral <<< "SOL"

#grompp_d -f IONS.mdp -c solv_na.gro -p prm.top -o ions_na_mg.tpr
#genion_d -s ions_na_mg.tpr -o solv_na_mg.gro -p prm.top -pname MG -pq 2 -nname CL -nq -1 -neutral -conc 0.04 <<< "SOL" #-np 128


#We are going to be conducting these simulations in the presence of 100 mM NaCl, on top of neutralizing counterions
