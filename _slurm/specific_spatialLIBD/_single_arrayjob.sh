#!/bin/bash

pckg=$1

samples_file="spatialLIBD_samples_shuffle_filters_2_01_rep1"

IFS=_ read A B C D E F G <<< ${samples_file}

log_path="$PWD/log_${C}_${D}_${E}_${F}_${G}"
mkdir -p ${log_path}

slurm_id=$(sbatch -o ${log_path}/slurm-${pckg}-%A_%a.out ${pckg}_slurm.sh "${samples_file}.txt")
echo "${slurm_id}  -  ${pckg}"