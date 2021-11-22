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


if [[ -z "$1" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

dataset=$1

cd ../giotto
echo "======= Giotto ======="
# Setup Giotto
python3.8 -m venv .venv
. .venv/bin/activate
which pip
pip install --upgrade pip
pip install --upgrade setuptools
pip install --upgrade wheel
pip install -r requirements.txt
Rscript -e "renv::init()" &> setup.txt
# Benchmark Giotto
/usr/bin/time -v -o bench_binspect_kmeans_${dataset}.txt ./benchmark_binspect_kmeans.R ${dataset} &> stdoe_binspect_kmeans_${dataset}.txt
/usr/bin/time -v -o bench_binspect_rank_${dataset}.txt ./benchmark_binspect_rank.R ${dataset} &> stdoe_binspect_rank_${dataset}.txt
/usr/bin/time -v -o bench_silhouette_${dataset}.txt ./benchmark_silhouette.R ${dataset} &> stdoe_silhouette_${dataset}.txt
