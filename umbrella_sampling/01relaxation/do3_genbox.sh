#TIP3p --> spc216
#gmx solvate -cp newbox.gro -cs spc216.gro -o solv.gro -p prm.top 
genbox_d -cp newbox.gro -cs spc216.gro -o solv.gro -p prm.top 
 
#  When using any 3-point model (e.g. SPC, SPC/E or TIP3P) you should specify -cs spc216.gro which will take this file from the gromacs/share/top directory.
