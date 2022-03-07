#!/bin/bash

dataset=$1
libd_sample=$2
shuffle=$3

if [[ $shuffle != "yes" && $shuffle != "no" ]]
then
    echo "Shuffle param wrong"
    exit 1
fi

base_folder="datasets_and_results"

if [ $shuffle == "yes" ]
then
   datasets_folder="${base_folder}/shuffled/${dataset}_${libd_sample}"
   base_file="${datasets_folder}/spe_${dataset}_${libd_sample}_shuffled"
else
   datasets_folder="${base_folder}/normal/${dataset}_${libd_sample}"
   base_file="${datasets_folder}/spe_${dataset}_${libd_sample}"
fi

mkdir -p ${datasets_folder}

singularity exec --writable-tmpfs singularity/voyager.sif Rscript -e "source('/benchmark/utils.R'); spe_to_files('${dataset}', '${libd_sample}', '${shuffle}', '${base_file}');"
