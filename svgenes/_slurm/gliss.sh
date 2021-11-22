#!/bin/bash

#SBATCH --job-name="gliss"
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

shift

source /mnt/davidec/conda/bin/activate
conda activate voyager10
conda info

cd ../gliss

echo "======= Gliss ======="
# Setup Gliss
./clone_repo.sh 
python3.8 -m venv .venv
. .venv/bin/activate

pip install numpy==1.20
pip install -U wheel
pip install -U cython
pip install -r requirements.txt &> setup.txt

# Benchmark Gliss
/usr/bin/time -v -o bench_${dataset}.txt ./benchmark.py ${dataset} &> stdoe_${dataset}.txt
