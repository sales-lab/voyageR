#!/bin/bash

#
# Copyright 2021 Davide Corso
#

base_file=$1


echo "======= BOOST-GP ======="
# Benchmark BoostGP
/usr/bin/time -v -o ./bench.txt Rscript /benchmark/svgenes/boostgp/benchmark.R ${base_file} &> ./stdoe.txt
