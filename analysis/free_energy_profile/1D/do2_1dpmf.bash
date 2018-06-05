[hnishi@fs10 fel01]$ cat do2_1dpmf.bash
#!/bin/bash -eu

fn_exe=./hist2kcal.py
fn_in=distr_angle.xvg
fn_out=pmf1d.xvg

python $fn_exe $fn_in  > $fn_out

