#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= SingleCellHaystack ======="
# Benchmark SingleCellHaystack
/usr/bin/time -v -o ./bench.txt Rscript /benchmark/svgenes/singlecellhaystack/benchmark.R ${base_file} &> ./stdoe.txt
