#!/bin/bash

#SBATCH --job-name="spark"
#SBATCH --mail-type=ALL
#SBATCH --time=96:00:00
#SBATCH --cpus-per-task=4
#SBATCH --mem=50G
#SBATCH --nodelist=xen5

#
# Copyright 2021 Davide Corso
#


if [[ -z "$1" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

dataset=$1

cd ../spark
echo "======= SPARK ======="
# Setup Spark
Rscript -e "renv::init()" &> setup.txt
# Benchmark Spark
/usr/bin/time -v -o bench_spark_${dataset}.txt ./benchmark_spark.R ${dataset} &> stdoe_spark_${dataset}.txt

# Benchmark Spark-X
/usr/bin/time -v -o bench_sparkX_${dataset}.txt ./benchmark_sparkX.R ${dataset} &> stdoe_sparkX_${dataset}.txt

