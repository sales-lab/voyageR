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
   dataset_name = "${dataset}_${libd_sample}"
else
   dataset_name = "${dataset}"
fi

mount_host=results_${dataset_name}/svgenes/${package}
mount_container=/results/svgenes/${package}

mkdir -p ${mount_host}

singularity exec --writable-tmpfs --bind ${mount_host}:${mount_container} singularity/voyager.sif python3 /benchmark/benchmark_svgenes.py ${package} -d ${dataset} -l ${libd_sample}
