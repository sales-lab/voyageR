#!/bin/bash

dataset=$1
libd_sample=$2
shuffle=$3
filter_genes_ncounts=$4
filter_genes_pcspots=$5

if [[ $shuffle != "yes" && $shuffle != "no" ]]
then
    echo "Shuffle param wrong"
    exit 1
fi

base_folder="datasets_and_results"

if [ $shuffle == "yes" ]
then
   datasets_folder="${base_folder}/shuffled_${filter_genes_ncounts}_${filter_genes_pcspots}/${dataset}_${libd_sample}"
   base_file="${datasets_folder}/spe_${dataset}_${libd_sample}_shuffled"
else
   datasets_folder="${base_folder}/normal_${filter_genes_ncounts}_${filter_genes_pcspots}/${dataset}_${libd_sample}"
   base_file="${datasets_folder}/spe_${dataset}_${libd_sample}"
fi

checking_file_python="${base_file}.h5ad"
checking_file_r="${base_file}.rds"

if [[ ! -f ${checking_file_python} && ! -f ${checking_file_r} ]]; then
   mkdir -p ${datasets_folder} /tmp/cache

   export SINGULARITYENV_XDG_CACHE_HOME=/tmp/cache
   singularity exec --writable-tmpfs --no-home singularity/voyager.sif Rscript -e "source('/benchmark/utils.R'); spe_to_files('${dataset}', '${libd_sample}', '${shuffle}', '${base_file}', '${filter_genes_ncounts}', '${filter_genes_pcspots}');"
fi
