#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= Giotto ======="
# Benchmark Giotto
/usr/bin/time -v -o ./bench_binspect_kmeans.txt Rscript /benchmark/svgenes/giotto/benchmark_binspect_kmeans.R ${base_file} &> ./stdoe_binspect_kmeans.txt
/usr/bin/time -v -o ./bench_binspect_rank.txt Rscript /benchmark/svgenes/giotto/benchmark_binspect_rank.R ${base_file} &> ./stdoe_binspect_rank.txt
/usr/bin/time -v -o ./bench_silhouette.txt Rscript /benchmark/svgenes/giotto/benchmark_silhouette.R ${base_file} &> ./stdoe_silhouette.txt
