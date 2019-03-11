#gmx editconf -f complex.gro -o newbox.gro -center 3.280 2.181 2.4775 -box 6.560 4.362 12

#geometrical center is a half of x and y axec of the box
#editconf_d -f complex.gro -o minmax.gro -d 1.2 

#1.2nm box,  11.33400  10.58300   9.43500
editconf_d -f complex.gro -o newbox.gro -center 6.573 5.498 3.725 -box 13.145 10.996 18

#check pbc using tk console in VMD by typing "pbc box"

#You can visualize the location of the protofibril within the box using, for example, VMD. Load the structure in VMD and open the Tk console. Type the following (note that > indicates the Tk prompt, not something you actually type):
#> pbc box
