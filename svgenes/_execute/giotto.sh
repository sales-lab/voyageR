#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1
libd_sample=$2


echo "======= Giotto ======="
# Benchmark Giotto
/usr/bin/time -v -o ./bench_binspect_kmeans_${dataset}.txt Rscript /benchmark/svgenes/giotto/benchmark_binspect_kmeans.R ${dataset} ${libd_sample} &> ./stdoe_binspect_kmeans_${dataset}.txt
/usr/bin/time -v -o ./bench_binspect_rank_${dataset}.txt Rscript /benchmark/svgenes/giotto/benchmark_binspect_rank.R ${dataset} ${libd_sample} &> ./stdoe_binspect_rank_${dataset}.txt
/usr/bin/time -v -o ./bench_silhouette_${dataset}.txt Rscript /benchmark/svgenes/giotto/benchmark_silhouette.R ${dataset} ${libd_sample} &> ./stdoe_silhouette_${dataset}.txt
