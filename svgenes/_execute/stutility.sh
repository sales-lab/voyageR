#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= STutility ======="
# Benchmark STutility
/usr/bin/time -v -o ./bench_${dataset}.txt Rscript /benchmark/svgenes/stutility/benchmark.R ${dataset} &> ./stdoe_${dataset}.txt
