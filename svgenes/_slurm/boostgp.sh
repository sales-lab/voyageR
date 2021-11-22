#!/bin/bash

#SBATCH --job-name="boostgp"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --nodelist=xen5

#
# Copyright 2021 Davide Corso
#

cd /mnt/davidec/conda/
source bin/activate
conda activate voyager7
cd /mnt/davidec/spatial-benchmark/svgenes/_slurm


if [[ -z "$1" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

dataset=$1

cd /mnt/davidec/conda/
source bin/activate
conda activate voyager7
cd /mnt/davidec/spatial-benchmark/svgenes/_slurm

cd ../boostgp
echo "======= BOOST-GP ======="
# Setup BoostGP
./clone_repo.sh 
Rscript -e "renv::init()" &> setup.txt
# Benchmark BoostGP
/usr/bin/time -v -o bench_${dataset}.txt ./benchmark.R ${dataset} &> stdoe_${dataset}.txt
