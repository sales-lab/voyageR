#!/bin/bash

#
# Copyright 2021 Davide Corso
#

dataset=$1
libd_sample=$2


echo "======= BOOST-GP ======="
# Benchmark BoostGP
/usr/bin/time -v -o ./bench_${dataset}.txt Rscript /benchmark/svgenes/boostgp/benchmark.R ${dataset} ${libd_sample} &> ./stdoe_${dataset}.txt
