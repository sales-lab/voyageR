#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= Seurat ======="
# Benchmark Seurat
/usr/bin/time -v -o ./bench_markvariogram_${dataset}.txt Rscript /benchmark/svgenes/seurat/benchmark_markvariogram.R ${dataset} &> ./stdoe_markvariogram_${dataset}.txt
/usr/bin/time -v -o ./bench_moransi_${dataset}.txt Rscript /benchmark/svgenes/seurat/benchmark_moransi.R ${dataset} &> ./stdoe_moransi_${dataset}.txt
