#!/bin/bash

dataset=$1
libd_sample=$2

dir=prepared_datasets

mkdir -p ${dir}

filename="${dir}/SpE_${dataset}_${libd_sample}.h5ad"

singularity exec --writable-tmpfs singularity/voyager.sif Rscript -e "source('/benchmark/utils.R'); spe_to_h5ad('${dataset}', '${libd_sample}', '${filename}');"
