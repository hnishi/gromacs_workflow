
# mdrun ノード数，コア数 設定

GPUの数をPP (Particle-particle) nodeの数に合わせる。

*参考* Gromacs4.6.6マニュアル62ページ「3.18.5 Multiple-Programing, Multiple-Data PME parallelization」

mdrunオプションの -gpu_id で使うGPUを指定できる。

（例）24MPI、20PPノード、4PMEノードの場合
-gpu_id 000000000000111111111111 
GPU2個を10プロセスずつで共有する。

PMEノードとDD (Domain Decomposition; =PP)ノードの数はmdrunの -npmeオプションと -ddオプションで以下のように指定できる。
`mpijob /home/k0072/k007200/hnishi/sw/gromacs-4.6.6-gpu/bin/mdrun_mpi -v -deffnm md3 -gpu_id 000000000011111111111 -npme 3 -dd 7 3 1 > md3.log2 2>&1`
PP node = 7\*3\*1 = 21

