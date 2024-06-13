#!/bin/bash

#SBATCH --job-name=jupyter-server
#SBATCH --partition=cmps-ai
#SBATCH --account=my_account

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=12000
#SBATCH --time=0-24:00:00
#SBATCH --account=foo_project

source ~/.bashrc

module purge
module load python/3
module load python/tensorflow
module load python/pytorch
module load python/transformers
module load python/HappyTransformer

JUPYTER_PORT=$(random_unused_port)

jupyter-lab  --no-browser --port=${JUPYTER_PORT} > jupyter-${SLURM_JOB_ID}.log 2>&1 &
ssh -R localhost:${JUPYTER_PORT}:localhost:${JUPYTER_PORT} ohead1 -N
