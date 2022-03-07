#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= Somde ======="
# Benchmark Somde
/usr/bin/time -v -o ./bench.txt python3 /benchmark/svgenes/somde/benchmark.py ${base_file} &> ./stdoe.txt
