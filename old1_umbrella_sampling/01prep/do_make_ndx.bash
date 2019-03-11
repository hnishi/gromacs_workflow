make_ndx_d -f min2.gro -o index_axrst << _EOF
r 1-76
r 77-152
r 1-76 & ! a H*
r 77-152 & ! a H*
a 2692 4493 
a 3303 3905 
a 2692 3303  
a 3905 4493
q
_EOF

#make_ndx -f min2.gro << _EOF
#a 4803-5336 
#name 21 Chain_E
#q
#_EOF

#5336

#r 1-27
#name 19 Chain_A
#r 28-54
#name 20 Chain_B
#q
#_EOF
