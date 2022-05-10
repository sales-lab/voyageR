#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= nnSVG ======="
# Benchmark nnSVG
/usr/bin/time -v -o ./bench.txt Rscript /benchmark/svgenes/nnsvg/benchmark.R ${base_file} &> ./stdoe.txt
