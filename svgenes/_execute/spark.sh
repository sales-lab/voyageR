#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1
libd_sample=$2


echo "======= SPARK ======="
# Benchmark Spark
/usr/bin/time -v -o ./bench_spark_${dataset}.txt Rscript /benchmark/svgenes/spark/benchmark_spark.R ${dataset} ${libd_sample} &> ./stdoe_spark_${dataset}.txt

# Benchmark Spark-X
/usr/bin/time -v -o ./bench_sparkX_${dataset}.txt Rscript /benchmark/svgenes/spark/benchmark_sparkX.R ${dataset} ${libd_sample} &> ./stdoe_sparkX_${dataset}.txt

