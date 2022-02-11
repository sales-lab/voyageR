#!/bin/bash

#SBATCH --job-name="svg_benchmark"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=100G
#SBATCH --nodelist=xen5
#SBATCH --array=1-14

#
# Copyright 2021 Davide Corso
#

dataset=$1

package="$(tail -n +$SLURM_ARRAY_TASK_ID packages_svgenes.txt | head -n1)"

mount_host=results_${dataset}/svgenes/${package}
mount_container=/results/svgenes/${package}

mkdir -p ${mount_host}

singularity exec --bind ${mount_host}:${mount_container} singularity/voyager.sif bash /benchmark/benchmark_svgenes.sh -p ${package} -d ${dataset}
