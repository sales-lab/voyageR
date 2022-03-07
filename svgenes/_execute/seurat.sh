#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= Seurat ======="
# Benchmark Seurat
/usr/bin/time -v -o ./bench_markvariogram.txt Rscript /benchmark/svgenes/seurat/benchmark_markvariogram.R ${base_file} &> ./stdoe_markvariogram.txt
/usr/bin/time -v -o ./bench_moransi.txt Rscript /benchmark/svgenes/seurat/benchmark_moransi.R ${base_file} &> ./stdoe_moransi.txt
