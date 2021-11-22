#!/bin/bash

#SBATCH --job-name="seurat"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --nodelist=xen5

#
# Copyright 2021 Davide Corso
#

if [[ -z "$1" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

dataset=$1

cd ../seurat
echo "======= Seurat ======="
# Setup Seurat
ulimit -s 40960
Rscript -e "renv::init()" &> setup.txt
# Benchmark Seurat
/usr/bin/time -v -o bench_markvariogram_${dataset}.txt ./benchmark_markvariogram.R ${dataset} &> stdoe_markvariogram_${dataset}.txt
/usr/bin/time -v -o bench_moransi_${dataset}.txt ./benchmark_moransi.R ${dataset} &> stdoe_moransi_${dataset}.txt
