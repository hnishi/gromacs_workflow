# Various ways to create a 2D heat map from ascii data
#

## *** eps
#set term postscript eps color enhanced "Arial" 20
#set output "pmf.eps"

## *** png
#set term pngcairo transparent truecolor font "Arial,24" size 1200,1000 
#set term pngcairo transparent truecolor font "Times New Roman,45" size 1200,1000 
set term pngcairo transparent truecolor font "Times New Roman,24" size 1200,1000 
set output "out_pmfnishi.dat.png"

## *** svg
#set term svg enhanced font "Arial, 14" # in svg, 100=1inch
#set output "out_pmf.svg"
#set encoding iso_8859_1

#set title "Heat Map generated from a file containing Z values only"
unset key
#set tic scale 0.3
set size square
#set grid
#set xtics 5 
#set ytics out

## *** Color runs from white to green
set palette defined (0"midnight-blue",1"blue",5"cyan",9"orange",13"red",14 "white")
#set palette defined (0"midnight-blue",1"blue",5"cyan",9"orange",13"red",14 "white")
#set palette defined (0"midnight-blue",1"blue",5"white",10"brown",11"white")
#set palette defined (0"midnight-blue",1"blue",5"white",10"dark-orange")
#set palette defined (0"midnight-blue",1"blue",5"white",10"#E41B17")
#set palette defined (0"midnight-blue",1"blue",5"white",10"#EF2800")
#set palette defined (0"midnight-blue",1"medium-blue",4.9"#e6e6ff",5"white",5.1"#ffe6e6",10"#b30000")
#set palette defined (0"midnight-blue",1"medium-blue",4.75"#ccccff",5"#e6e6e6",5.25"#ffcccc",10"#b30000")
#set palette defined (0"midnight-blue",1"medium-blue",5"#e6e6e6",10"#b30000")
#set palette defined (0"midnight-blue",1"blue",10"red",11"white")
#set palette defined (0 "black",1 "white")
#set palette defined (0 "white",1 "black")
set cbrange [0:4]
#set cbrange [0:3.6]
#set cblabel "(kcal/mol)"
#set cbtics format "%1.1f"
set cbtics format "%.1f"
#set format  x "%.0f"  #integer
#unset cbtics
#set format x ""
#set format y ""
#set xlabel "NHelix"
#set ylabel "Rg"

#set xrange [-0.5:26.5]
#set yrange [-0.5:26.5]
#set xrange [-0.5:18.5]
#set yrange [-0.5:15.5]
#
## FOR splot pm3d
set xrange [0:18]
set yrange [0:15]

set xtics rotate by 90 right
set xtics center offset 0,0.5

$map1 << EOD
5 4 3 1 0
2 2 0 0 1
0 0 0 1 0
0 0 0 2 3
0 1 2 4 3
EOD

set datafile separator comma
set view map

## splot pm3d
set pm3d map
set pm3d interpolate 5,5
#set pm3d interpolate 2,2
splot "out_pmfnishi_mod.dat" matrix rowheaders columnheaders 
#splot "out_pmfnishi.dat" matrix rowheaders columnheaders 

## simple matrix plot
#splot "out_pmfnishi.dat" matrix rowheaders columnheaders with image
#
## plot with value labels
#plot "out_do4_matrix.dat" matrix using 1:2:3 with image, \
#     "out_do4_matrix.dat" matrix using 1:2:($3 == 0 ? "" : sprintf("%g",$3) ) with labels

$map3 << EOD
,Apple,Bacon,Cream,Donut,Eclair
Row 1, 5, 4, 3, 1, 0
Row 2, 2, 2, 0, 0, 1
Row 3, 0, 0, 0, 1, 0
Row 4, 0, 0, 0, 2, 3
Row 5, 0, 1, 2, 4, 3
EOD

## with axis labels
#set datafile separator comma
#plot '$map3' matrix rowheaders columnheaders using 1:2:3 with image
#plot "out_do4_matrix.dat" matrix rowheaders columnheaders using 1:2:3 with image
#set datafile separator

#pause -1

