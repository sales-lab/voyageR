#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= MERINGUE ======="
# Benchmark Meringue
/usr/bin/time -v -o ./bench_${dataset}.txt Rscript /benchmark/svgenes/meringue/benchmark.R ${dataset} &> ./stdoe_${dataset}.txt
