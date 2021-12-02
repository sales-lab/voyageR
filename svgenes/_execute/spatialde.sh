#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= SpatialDE ======="
# Benchmark SpatialDE
/usr/bin/time -v -o ./bench_${dataset}.txt python3 /benchmark/svgenes/spatialde/benchmark.py ${dataset} &> ./stdoe_${dataset}.txt
