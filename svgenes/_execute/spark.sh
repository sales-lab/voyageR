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


dataset=$1
output_folder=$2

cd ../spark
echo "======= SPARK ======="
# Benchmark Spark
/usr/bin/time -v -o ${output_folder}/bench_spark_${dataset}.txt ./benchmark_spark.R ${dataset} &> ${output_folder}/stdoe_spark_${dataset}.txt

# Benchmark Spark-X
/usr/bin/time -v -o ${output_folder}/bench_sparkX_${dataset}.txt ./benchmark_sparkX.R ${dataset} &> ${output_folder}/stdoe_sparkX_${dataset}.txt

