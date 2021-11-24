#!/bin/bash

#SBATCH --job-name="giotto"
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

cd ../giotto
echo "======= Giotto ======="
# Benchmark Giotto
/usr/bin/time -v -o ${output_folder}/bench_binspect_kmeans_${dataset}.txt ./benchmark_binspect_kmeans.R ${dataset} &> ${output_folder}/stdoe_binspect_kmeans_${dataset}.txt
/usr/bin/time -v -o ${output_folder}/bench_binspect_rank_${dataset}.txt ./benchmark_binspect_rank.R ${dataset} &> ${output_folder}/stdoe_binspect_rank_${dataset}.txt
/usr/bin/time -v -o ${output_folder}/bench_silhouette_${dataset}.txt ./benchmark_silhouette.R ${dataset} &> ${output_folder}/stdoe_silhouette_${dataset}.txt
