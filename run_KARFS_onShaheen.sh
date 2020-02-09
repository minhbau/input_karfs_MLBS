#!/bin/bash
#SBATCH --account=k1164 
#SBATCH --job-name=karfs_MLBS
#SBATCH -o %j.out
#SBATCH -e %j.err
###SBATCH --output=job_name.out
###SBATCH --error=job_name.err
#SBATCH --partition=debug
#SBATCH --nodes=2
#SBATCH --time=00:20:00

# ==================================
# Modules and environment variables
# ==================================
module swap PrgEnv-cray PrgEnv-intel
module load cray-python/2.7.15.7
module load cray-hdf5-parallel/1.10.5.2
module load gcc/8.3.0
# update the newest compliers if needed
module load cdt/19.12 

# Add  myboost module  to MODULEPATH:
export MODULEPATH="$MODULEPATH:/project/k1164/shared/modulefiles"
module load myboost-intel/1.67

# ==================================



#OMP_NUM_THREADS=1  srun -n 64  --hint=no multithread
echo " My mpi job is running.."

export OMP_NUM_THREADS=1
srun --hint=nomultithread  --ntasks=64  ./DNS	-i Input.txt -m ethanolSk40.xml >logfile.out 
echo " OMP_NUM_THREADS=1 DONE"
#sbatch run_KARFS_onShaheen.sh


#
#OMP_NUM_THREADS=2
#srun --ntasks=4096 ./PlanarFlameDriver -i taylorgreen3Dmix-reacting.txt -m h2_williams_12.xml >> testDifferent_nThread_nx16.out &&
#echo " OMP_NUM_THREADS=2 DONE"

#export OMP_NUM_THREADS=4 
#srun --ntasks=4096 ./PlanarFlameDriver -i taylorgreen3Dmix-reacting.txt -m h2_williams_12.xml >> testDifferent_nThread_nx16.out &&
#echo " OMP_NUM_THREADS=4 DONE"
#
#
#export OMP_NUM_THREADS=8
#srun --ntasks=4096 ./PlanarFlameDriver -i taylorgreen3Dmix-reacting.txt -m h2_williams_12.xml >> testDifferent_nThread_nx16.out &&
#echo " OMP_NUM_THREADS=8 DONE"



#srun --ntasks=32 ./s3d_f90.x > s3d_f90.out

# mpirun -mode VN -np 4096 -cwd $PWD -exe ./s3d_f90.x >s3d.out
#mpirun -mode VN -np 1024 -env BG_MAPPING=TXYZ -cwd $PWD -exe ./s3d_f90.x >s3d.out
