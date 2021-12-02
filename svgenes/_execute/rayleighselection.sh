#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= RayleighSelection ======="
# Benchmark RayleighSelection
/usr/bin/time -v -o ./bench_${dataset}.txt Rscript /benchmark/svgenes/rayleighselection/benchmark.R ${dataset} &> ./stdoe_${dataset}.txt
