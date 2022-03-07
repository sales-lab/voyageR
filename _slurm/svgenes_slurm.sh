#!/bin/bash

#SBATCH --job-name="svg_benchmark"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=100G
#SBATCH --array=1-14

#
# Copyright 2021 Davide Corso
#

dataset=$1
libd_sample=$2

package="$(tail -n +$SLURM_ARRAY_TASK_ID packages_svgenes.txt | head -n1)"

echo "=== package: ${package} === dataset: ${dataset} === libd_sample: ${libd_sample} ==="

if [ $dataset == "spatialLIBD" ]
then
   dataset_name="${dataset}_${libd_sample}"
else
   dataset_name="${dataset}"
fi

mount_host=results_${dataset_name}/svgenes/${package}
mount_container=/results/svgenes/${package}

host_datasets=prepared_datasets
container_dataset=/benchmark/datasets

mount -p ${mount_host}

checking_file="${host_datasets}/SpE_${dataset}_${libd_sample}.h5ad"

if [ ! -f ${checking_file} ]; then
    echo "${checking_file} file not found."
    exit 1
fi

singularity exec --writable-tmpfs --bind ${mount_host}:${mount_container} --bind ${host_datasets}:${container_dataset} singularity/voyager.sif python3 /benchmark/benchmark_svgenes.py -p ${package} -d ${dataset} -l ${libd_sample}
