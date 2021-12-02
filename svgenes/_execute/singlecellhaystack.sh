#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= SingleCellHaystack ======="
# Benchmark SingleCellHaystack
/usr/bin/time -v -o ./bench_${dataset}.txt Rscript /benchmark/svgenes/singlecellhaystack/benchmark.R ${dataset} &> ./stdoe_${dataset}.txt
