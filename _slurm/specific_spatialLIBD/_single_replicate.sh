#!/bin/bash

pckg=$1

fullsample="replicates/spatialLIBD_samples_shuffle_filters_2_01_rep2.txt"

basefile=$(basename ${fullsample})
IFS=. read samples_file ext <<< ${basefile}
echo "$samples_file"

IFS=_ read A B C D E F G <<< ${samples_file}

log_path="$PWD/replicates/log_${C}_${E}_${F}/${G}"
mkdir -p ${log_path}

echo "${pckg}_slurm.sh"
sbatch -o ${log_path}/slurm-${pckg}-%A_%a.out ${pckg}_slurm.sh "${fullsample}"
