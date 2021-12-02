#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= scGCO ======="
# Benchmark scGCO
/usr/bin/time -v -o ./bench_${dataset}.txt python3 /benchmark/svgenes/scgco/benchmark.py ${dataset} &> ./stdoe_${dataset}.txt
