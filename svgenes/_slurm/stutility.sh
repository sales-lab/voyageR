#!/bin/bash

#SBATCH --job-name="stutility"
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

cd ../stutility
echo "======= STutility ======="
# Setup STutility
Rscript -e "renv::init()" &> setup.txt
# Benchmark STutility
/usr/bin/time -v -o bench_${dataset}.txt ./benchmark.R ${dataset} &> stdoe_${dataset}.txt
