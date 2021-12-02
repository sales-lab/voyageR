#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= Giotto ======="
# Benchmark Giotto
/usr/bin/time -v -o ./bench_binspect_kmeans_${dataset}.txt Rscript /benchmark/svgenes/giotto/benchmark_binspect_kmeans.R ${dataset} &> ./stdoe_binspect_kmeans_${dataset}.txt
/usr/bin/time -v -o ./bench_binspect_rank_${dataset}.txt Rscript /benchmark/svgenes/giotto/benchmark_binspect_rank.R ${dataset} &> ./stdoe_binspect_rank_${dataset}.txt
/usr/bin/time -v -o ./bench_silhouette_${dataset}.txt Rscript /benchmark/svgenes/giotto/benchmark_silhouette.R ${dataset} &> ./stdoe_silhouette_${dataset}.txt
