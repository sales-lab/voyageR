#!/bin/bash

#SBATCH --job-name="meringue"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --nodelist=xen5

#
# Copyright 2021 Davide Corso
#

dataset=$1
output_folder=$2

cd ../meringue
echo "======= MERINGUE ======="
# Benchmark Meringue
/usr/bin/time -v -o ${output_folder}/bench_${dataset}.txt ./benchmark.R ${dataset} &> ${output_folder}/stdoe_${dataset}.txt
