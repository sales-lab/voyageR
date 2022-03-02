#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1
libd_sample=$2


echo "======= Seurat ======="
# Benchmark Seurat
/usr/bin/time -v -o ./bench_markvariogram_${dataset}.txt Rscript /benchmark/svgenes/seurat/benchmark_markvariogram.R ${dataset} ${libd_sample} &> ./stdoe_markvariogram_${dataset}.txt
/usr/bin/time -v -o ./bench_moransi_${dataset}.txt Rscript /benchmark/svgenes/seurat/benchmark_moransi.R ${dataset} ${libd_sample} &> ./stdoe_moransi_${dataset}.txt
