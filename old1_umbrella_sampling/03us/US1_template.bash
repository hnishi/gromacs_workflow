title       = Umbrella pulling simulation 
define      = -DPOSRES_DNA
; Run parameters
integrator  = md
dt          = 0.002
tinit       = 0
nsteps      = 10000000 ; 20 ns
nstcomm     = 10
; Output parameters
nstxout     = 0;1000 ;50000      ; every 100 ps
nstvout     = 0;50000      ; velocity
nstfout     = 0;5000      ; force 
nstxtcout   = 1000 ;5000      ; every 10 ps
nstenergy   = 1000
;xtc-grps    = 
nstenergy   = ;5000
; Bond parameters
constraint_algorithm    = lincs
constraints             = h-bonds ;all-bonds
continuation            = yes ;no ; yes       
; Single-range cutoff scheme
nstlist     = 5
ns_type     = grid 
rlist       = 1.4
rcoulomb    = 1.4
rvdw        = 1.4
; PME electrostatics parameters
coulombtype     = PME
fourierspacing  = 0.12
fourier_nx      = 0
fourier_ny      = 0
fourier_nz      = 0
pme_order       = 4
ewald_rtol      = 1e-5
optimize_fft    = yes
; Berendsen temperature coupling is on in two groups
Tcoupl      = v-rescale ;Nose-Hoover
tc_grps     = System ;Protein   Non-Protein 
tau_t       = 0.5    ;   0.5
ref_t       = 300    ;   310
; Pressure coupling is on
Pcoupl          = Parrinello-Rahman 
pcoupltype      = isotropic
tau_p           = 10.0       
compressibility = 4.5e-5
ref_p           = 1.0
refcoord_scaling = com
; Generate velocities is off
gen_vel     = no ;yes ;no
gen_temp    = 300
gen_seed    = 1111 ;-1
; Periodic boundary conditions are on in all directions
pbc     = xyz
; Long-range dispersion correction
DispCorr    = EnerPres
; Pull code
; changes below are rewritten for gromacs4.6.6
;pull                    = yes  ;activates the pull code. Must be set to yes for any of these options to take effect.
pull                    = umbrella  ;activates the pull code. Must be set to yes for any of these options to take effect.
;pull_ngroups            = 2  ;two groups that are subject to a biasing potential
pull-ngroups            = 1  ;two groups that are subject to a biasing potential
;pull_ncoords            = 1  ;only one reaction coordinate
;pull_group1_name        = Chain_A  ;the name in the index file of the first group
pull_group0        = r_1-76 ;DNA      ;the name in the index file of the first group
;pull_group2_name        = Chain_B  ;the name in the index file of the second group
pull_group1        = r_77-152 ; a_6405-6938 ; a_4803-5336 ;a_5337-5870  ;the name in the index file of the second group
;pull_coord1_type        = umbrella      ; harmonic biasing force
;pull_coord1_geometry    = distance      ; simple distance increase
pull-geometry    = distance      ; simple distance increase
;pull_coord1_groups      = 1 2
;pull_coord1_dim         = N N Y
pull-dim         = N N Y
;pull_coord1_rate        = 0.0          ; 0.01 nm per ps = 10 nm per ns ; 5nm <-- 500ps
pull-rate1        = 0.0      ; nm/ps 
;pull_coord1_k           = 1000          ; kJ mol^-1 nm^-2
pull-k1           = 100 ;1000          ; kJ mol^-1 nm^-2
;pull_coord1_start       = yes           ; define initial COM distance > 0
pull-start       = yes           ; define initial COM distance > 0
pull-nstxout     = 1
pull-nstfout     = 1
