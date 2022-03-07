#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= RayleighSelection ======="
# Benchmark RayleighSelection
/usr/bin/time -v -o ./bench.txt Rscript /benchmark/svgenes/rayleighselection/benchmark.R ${base_file} &> ./stdoe.txt
