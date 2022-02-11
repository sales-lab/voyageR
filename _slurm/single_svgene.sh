#!/bin/bash

#SBATCH --job-name="svg_benchmark"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --nodelist=xen5

#
# Copyright 2021 Davide Corso
#


package=$1
dataset=$2

mount_host=results_single/svgenes/${package}
mount_container=/results/svgenes/${package}

mkdir -p ${mount_host}

singularity exec --bind ${mount_host}:${mount_container} singularity/voyager.sif bash /benchmark/benchmark_svgenes.sh -p ${package} -d ${dataset}
