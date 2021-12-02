#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= Somde ======="
# Benchmark Somde
/usr/bin/time -v -o ./bench_${dataset}.txt python3 /benchmark/svgenes/somde/benchmark.py ${dataset} &> ./stdoe_${dataset}.txt
