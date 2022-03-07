#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= JSTA ======="
# Benchmark JSTA
/usr/bin/time -v -o ./bench.txt python3 /benchmark/svgenes/jsta/benchmark.py ${base_file} &> ./stdoe.txt
