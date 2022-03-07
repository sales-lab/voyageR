#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= scGCO ======="
# Benchmark scGCO
/usr/bin/time -v -o ./bench.txt python3 /benchmark/svgenes/scgco/benchmark.py ${base_file} &> ./stdoe.txt
