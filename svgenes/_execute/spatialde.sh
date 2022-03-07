#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= SpatialDE ======="
# Benchmark SpatialDE
/usr/bin/time -v -o ./bench.txt python3 /benchmark/svgenes/spatialde/benchmark.py ${base_file} &> ./stdoe.txt
