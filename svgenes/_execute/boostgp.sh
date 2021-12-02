#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1


echo "======= BOOST-GP ======="
# Benchmark BoostGP
/usr/bin/time -v -o ./bench_${dataset}.txt Rscript /benchmark/svgenes/boostgp/benchmark.R ${dataset} &> ./stdoe_${dataset}.txt
