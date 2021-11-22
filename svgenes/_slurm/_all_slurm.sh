#!/bin/bash
#
# Copyright 2021 Davide Corso
#


# [^_]* means all files excluding those starting with _


if [[ -z "$1" ]] ; then
    echo 'No dataset supplied'
    exit 1
fi

dataset=$1

sbatch _python_setup.sh

for f in [^_]*; do
    sbatch --dependency=$(squeue --noheader --format %i --name _python_setup) $f ${dataset}
done
