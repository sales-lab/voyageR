#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= MERINGUE ======="
# Benchmark Meringue
/usr/bin/time -v -o ./bench.txt Rscript /benchmark/svgenes/meringue/benchmark.R ${base_file} &> ./stdoe.txt
