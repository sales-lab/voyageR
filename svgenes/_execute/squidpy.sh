#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= Squidpy ======="
# Benchmark Squidpy
/usr/bin/time -v -o ./bench_moransi.txt python3 /benchmark/svgenes/squidpy/benchmark_moransi.py ${base_file} &> ./stdoe_moransi.txt
/usr/bin/time -v -o ./bench_gearyc.txt python3 /benchmark/svgenes/squidpy/benchmark_gearyc.py ${base_file} &> ./stdoe_gearyc.txt
