#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= SPARK ======="
# Benchmark Spark
/usr/bin/time -v -o ./bench_spark.txt Rscript /benchmark/svgenes/spark/benchmark_spark.R ${base_file} &> ./stdoe_spark.txt

# Benchmark Spark-X
/usr/bin/time -v -o ./bench_sparkX.txt Rscript /benchmark/svgenes/spark/benchmark_sparkX.R ${base_file} &> ./stdoe_sparkX.txt
