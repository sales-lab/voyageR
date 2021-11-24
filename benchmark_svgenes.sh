#!/bin/bash
#
# Copyright 2021 Davide Corso
#

package=$1
dataset=$2
output_folder=$3


if [[ -z "$1" ]] ; then
    echo 'No package supplied'
    exit 1
fi

if [[ -z "$2" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

FILE="/benchmark/datasets/SpE_${dataset}.h5ad"
if [! -f "$FILE" ]; then
    cd /benchmark
    echo "Downloading dataset as SpatialExperiment..."
    Rscript -e "source('utils.R'); spe_to_h5ad('${dataset}', '${FILE}')"
fi

if [! -d "${output_folder}" ]; then
    echo 'No output folder supplied'
    exit 1
fi

if [[ -z "$2" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

DIR="/benchmark/svgenes/${package}"
if [ -d "$DIR" ]; then  
  cd "/benchmark/_execute/"
  ./${package}.sh ${dataset} ${output_folder}
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Error: ${DIR} not found."
  exit 1
fi
