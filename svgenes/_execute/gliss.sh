#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= Gliss ======="
# Benchmark Gliss
/usr/bin/time -v -o ./bench_${dataset}.txt python3 /benchmark/svgenes/gliss/benchmark.py ${dataset} &> ./stdoe_${dataset}.txt
