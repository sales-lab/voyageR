#!/bin/bash

#SBATCH --job-name="scGCO"
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

cd ../scgco
echo "======= scGCO ======="
# Setup scGCO
python3.8 -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt &> setup.txt
# Benchmark scGCO
/usr/bin/time -v -o bench_${dataset}.txt ./benchmark.py ${dataset} &> stdoe_${dataset}.txt
