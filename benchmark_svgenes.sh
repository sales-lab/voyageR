#!/bin/bash
#
# Copyright 2021 Davide Corso
#


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
    o ) output_folder=$OPTARG;;
    h ) usage
  esac
done


if [[ -z "$package" ]] ; then
    echo 'No package supplied'
    exit 1
fi

if [[ -z "$dataset" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

FILE="/benchmark/datasets/SpE_${dataset}.h5ad"
if [! -f "$FILE" ]; then
    cd /benchmark
    echo "Downloading dataset as SpatialExperiment..."
    Rscript -e "source('utils.R'); spe_to_h5ad('${dataset}', '${FILE}')"
fi

if [! -d $output_folder ]; then
    echo 'No output folder supplied'
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
