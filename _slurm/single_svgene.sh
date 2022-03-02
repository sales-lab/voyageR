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

if [ $dataset == "spatialLIBD" ]
then
   dataset_name="${dataset}_${libd_sample}"
else
   dataset_name="${dataset}"
fi

mount_host=results_single_${dataset_name}/svgenes/${package}
mount_container=/results/svgenes/${package}

mkdir -p ${mount_host}

singularity exec --writable-tmpfs --bind ${mount_host}:${mount_container} singularity/voyager.sif python3 /benchmark/benchmark_svgenes.py -p ${package} -d ${dataset} -l ${libd_sample}
