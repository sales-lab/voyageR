#!/bin/bash

#SBATCH --job-name="svg_benchmark"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --nodelist=xen5
#SBATCH --array=1-14

#
# Copyright 2021 Davide Corso
#

dataset=$1
output_folder=$2

package="$(tail -n +$SLURM_ARRAY_TASK_ID _slurm/svgenes_packages.txt | head -n1)"


singularity exec voyager bash /benchmark/benchmark_svgenes.sh -p ${package} -d ${dataset} -o ${output_folder}
