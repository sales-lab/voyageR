#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= JSTA ======="
# Benchmark JSTA
/usr/bin/time -v -o ./bench_${dataset}.txt python3 /benchmark/svgenes/jsta/benchmark.py ${dataset} &> ./stdoe_${dataset}.txt
