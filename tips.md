
# mdrun ノード数，コア数 設定

GPUの数をPP (Particle-particle) nodeの数に合わせる。

*参考* Gromacs4.6.6マニュアル62ページ「3.18.5 Multiple-Programing, Multiple-Data PME parallelization」

mdrunオプションの -gpu_id で使うGPUを指定できる。

（例）24MPI、20PPノード、4PMEノードの場合
-gpu_id 000000000000111111111111 
GPU2個を10プロセスずつで共有する。
