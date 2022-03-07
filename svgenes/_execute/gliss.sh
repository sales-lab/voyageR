#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= Gliss ======="
# Benchmark Gliss
/usr/bin/time -v -o ./bench.txt python3 /benchmark/svgenes/gliss/benchmark.py ${base_file} &> ./stdoe.txt
