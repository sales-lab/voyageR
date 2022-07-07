#!/bin/bash

samples_file="spatialLIBD_samples_normal_filters_3_05_rep1"

IFS=_ read A B C D E F G <<< ${samples_file}

log_path="$PWD/log_${C}_${D}_${E}_${F}_${G}"
mkdir -p ${log_path}

echo "$samples_file"

while read pckg; do
    if [[ "${pckg}" == 'boostgp' || "${pckg}" == 'gpcounts' || "${pckg}" == 'jsta' || "${pckg}" == 'stutility' || "${pckg}" == 'rayleighselection' ]]; then
        continue
    fi
    
    slurm_id=$(sbatch -o ${log_path}/slurm-${pckg}-%A_%a.out ${pckg}_slurm.sh "${samples_file}.txt")
    echo "${slurm_id}  -  ${pckg}"
    
done <../packages_svgenes.txt
