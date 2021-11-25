#!/bin/bash
#
# Copyright 2021 Davide Corso
#

set -e

function usage () {
    cat >&2 <<EOF
USAGE: ./benchmark_svgenes.sh [options]
Perform benchmark for specific package and dataset

-p <package>        : Package.  Required.
-d <dataset>        : 10xVisium dataset from TENxVisiumData Bioconductor package. Required.
-o <outputdir>      : Where to write output. Rquired
-h                  : Print usage and exit.
EOF
}

while getopts ":p:d:o:h" options; do
  case $options in
    p ) package=$OPTARG;;
    d ) dataset=$OPTARG;;
    h ) usage
            exit 1;;
  esac
done


if [ $# -eq 0 ]; then
    usage
    exit 1
fi

if [[ -z "$package" ]] ; then
    echo 'No package supplied'
    exit 1
fi

if [[ -z "$dataset" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

FILE="/benchmark/datasets/SpE_${dataset}.h5ad"
if [ ! -f "$FILE" ]; then
    cd /benchmark
    echo "Downloading dataset as SpatialExperiment..."
    Rscript -e "source('utils.R'); spe_to_h5ad('${dataset}', '${FILE}')"
fi

output_folder=/results/svgenes/${package}
DIR="/benchmark/svgenes/${package}"

if [ -d "$DIR" ]; then  
  mkdir -p ${output_folder}
  cd "/benchmark/svgenes/_execute/"
  ./${package}.sh ${dataset} ${output_folder}
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Error: package '${package}' not found."
  exit 1
fi
