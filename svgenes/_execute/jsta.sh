#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1
libd_sample=$2


echo "======= JSTA ======="
# Benchmark JSTA
/usr/bin/time -v -o ./bench_${dataset}.txt python3 /benchmark/svgenes/jsta/benchmark.py ${dataset} ${libd_sample} &> ./stdoe_${dataset}.txt
