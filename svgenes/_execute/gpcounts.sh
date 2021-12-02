#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= GPcounts ======="
# Benchmark GPcounts
/usr/bin/time -v -o ./bench_${dataset}.txt python3 /benchmark/svgenes/gpcounts/benchmark.py ${dataset} &> ./stdoe_${dataset}.txt
