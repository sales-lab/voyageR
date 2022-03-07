#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= STutility ======="
# Benchmark STutility
/usr/bin/time -v -o ./bench.txt Rscript /benchmark/svgenes/stutility/benchmark.R ${base_file} &> ./stdoe.txt
