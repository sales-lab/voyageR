#!/bin/bash


package=$1
libd_sample=$2
shuffle=$3
filter_genes_ncounts=$4  # esempio 4
float_filter_genes_pcspots=$5 # esempio 0.3
rep=$6

replaced_slurm_log=$7
replaced_slurm_log_array=$8

dataset="spatialLIBD"


if [ $shuffle == "yes" ]
then
   shfl="shuffle"
else
   shfl="normal"
fi

IFS=. read A B <<< ${float_filter_genes_pcspots}
filter_genes_pcspots="${A}${B}"

if [ $rep == "rep1" ]
then
   log_path="$PWD/log_${shfl}_filters_${filter_genes_ncounts}_${filter_genes_pcspots}_${rep}"
else
   log_path="$PWD/replicates/log_${shfl}_${filter_genes_ncounts}_${filter_genes_pcspots}/${rep}"
fi

slurm_id=$(sbatch -o ${log_path}/slurm-${package}-${replaced_slurm_log}_${replaced_slurm_log_array}_retry.out _custom_package_single_sample.sh ${package} ${dataset} ${libd_sample} ${shuffle} ${filter_genes_ncounts} ${float_filter_genes_pcspots} ${rep})

echo "${slurm_id} - ${package} - ${replaced_slurm_log} - ${replaced_slurm_log_array} - ${rep}"

