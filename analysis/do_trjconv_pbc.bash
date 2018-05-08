#!/bin/bash -eu

NAME=do_trjconv_pbc.bash
VERSION=1.1

fn_inp1=md_0to200ns_per200ps
fn_inp2=md1.tpr

trjconv_d -f ${fn_inp1}.xtc -s ${fn_inp2} -pbc nojump -o ${fn_inp1}_nojump.xtc <<< 0
trjconv_d -f ${fn_inp1}_nojump.xtc -s $fn_inp2 -center -o ${fn_inp1}_nojump_center.xtc <<_EOF
DNA
0
_EOF
trjconv_d -f ${fn_inp1}_nojump_center.xtc -s $fn_inp2 -pbc mol -ur rect -o ${fn_inp1}_nojump_center_rect.xtc <<< 0
