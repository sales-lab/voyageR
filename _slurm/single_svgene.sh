#!/bin/bash

#SBATCH --job-name="svg_benchmark"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=100G

#
# Copyright 2021 Davide Corso
#


package=$1
dataset=$2
libd_sample=$3

echo "=== package: ${package} === dataset: ${dataset} === libd_sample: ${libd_sample} ==="

if [ $dataset == "spatialLIBD" ]
then
   dataset_name="${dataset}_${libd_sample}"
else
   dataset_name="${dataset}"
fi

mount_host=results_single_${dataset_name}/svgenes/${package}
mount_container=/results/svgenes/${package}

host_datasets=prepared_datasets
container_dataset=/benchmark/datasets

checking_file="${host_datasets}/SpE_${dataset}_${libd_sample}.h5ad"

if [ ! -f ${checking_file} ]; then
    echo "${checking_file} file not found."
    exit 1
fi

mkdir -p ${mount_host}

singularity exec --writable-tmpfs --bind ${mount_host}:${mount_container} --bind ${host_datasets}:${container_dataset} singularity/voyager.sif python3 /benchmark/benchmark_svgenes.py -p ${package} -d ${dataset} -l ${libd_sample}
