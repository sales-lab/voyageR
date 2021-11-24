#!/bin/bash
#
# Copyright 2021 Davide Corso
#


if [[ -z "$1" ]] ; then
    echo 'No package supplied'
    exit 1
fi

package=$1

if [[ -z "$2" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

dataset=$2

FILE="/benchmark/datasets/SpE_${dataset}.h5ad"
if [! -f "$FILE" ]; then
    cd /benchmark
    echo "Downloading dataset as SpatialExperiment..."
    Rscript -e "source('utils.R'); spe_to_h5ad('${dataset}', '${FILE}')"
fi

if [! -d $3 ]; then
    echo 'No output folder supplied'
    exit 1
fi

output_folder=$3

DIR="/benchmark/svgenes/${package}"
if [ -d "$DIR" ]; then  
  cd "/benchmark/_execute/"
  ./${package}.sh ${dataset} ${output_folder}
else
  ###  Control will jump here if $DIR does NOT exists ###
  echo "Error: ${DIR} not found."
  exit 1
fi
