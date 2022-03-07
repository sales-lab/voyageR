#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= GPcounts ======="
# Benchmark GPcounts
/usr/bin/time -v -o ./bench.txt python3 /benchmark/svgenes/gpcounts/benchmark.py ${base_file} &> ./stdoe.txt
