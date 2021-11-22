#!/bin/bash

#SBATCH --job-name="_python_setup"
#SBATCH --mail-type=ALL
#SBATCH --time=00:30:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G

#
# Copyright 2021 Davide Corso
#


if [[ -z "$1" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

cd ../../datasets/

dataset=$1
filename="SpE_${dataset}.h5ad"

if [ -f "$filename" ]; then
    echo "$filename exists."
else 
    Rscript -e "renv::init(); source('../utils.R'); spe_to_h5ad('${dataset}', '${filename}')"    
fi
