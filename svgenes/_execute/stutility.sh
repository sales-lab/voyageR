#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1
libd_sample=$2


echo "======= STutility ======="
# Benchmark STutility
/usr/bin/time -v -o ./bench_${dataset}.txt Rscript /benchmark/svgenes/stutility/benchmark.R ${dataset} ${libd_sample} &> ./stdoe_${dataset}.txt
