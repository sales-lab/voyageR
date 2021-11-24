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

dataset=$1
output_folder=$2

cd ../seurat
echo "======= Seurat ======="
# Benchmark Seurat
/usr/bin/time -v -o ${output_folder}/bench_markvariogram_${dataset}.txt ./benchmark_markvariogram.R ${dataset} &> ${output_folder}/stdoe_markvariogram_${dataset}.txt
/usr/bin/time -v -o ${output_folder}/bench_moransi_${dataset}.txt ./benchmark_moransi.R ${dataset} &> ${output_folder}/stdoe_moransi_${dataset}.txt
