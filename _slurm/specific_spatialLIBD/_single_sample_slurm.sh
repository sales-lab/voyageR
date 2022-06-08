#!/bin/bash


#SBATCH --job-name="pckg_svg"
#SBATCH --mail-type=ALL
#SBATCH --time=20:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G


#
# Copyright 2022 Davide Corso
#

package=$1

dataset="spatialLIBD"
libd_sample="151507"
shuffle="yes"
filter_genes_ncounts="2"
filter_genes_pcspots="01"
rep="rep1"


slurm_execute () {
    echo "=== package: ${package} === dataset: ${dataset} === libd_sample: ${libd_sample} === shuffle: ${shuffle} === filter_genes_ncounts: ${filter_genes_ncounts} === filter_genes_pcspots: ${filter_genes_pcspots} ==="


    base_folder="../datasets_and_results"

    if [ $shuffle == "yes" ]
    then
    mount_host_datasets="${base_folder}/shuffled_${filter_genes_ncounts}_${filter_genes_pcspots}_${rep}/${dataset}_${libd_sample}"
    base_file="${mount_host_datasets}/spe_${dataset}_${libd_sample}_shuffled"
    else
    mount_host_datasets="${base_folder}/normal_${filter_genes_ncounts}_${filter_genes_pcspots}_${rep}/${dataset}_${libd_sample}"
    base_file="${mount_host_datasets}/spe_${dataset}_${libd_sample}"
    fi

    mount_container_dataset=/benchmark/datasets

    checking_file_python="${base_file}.h5ad"
    if [ ! -f ${checking_file_python} ]; then
        echo "${checking_file_python} python file not found."
        exit 1
    fi

    checking_file_r="${base_file}.rds"
    if [ ! -f ${checking_file_r} ]; then
        echo "${checking_file_r} R file not found."
        exit 1
    fi

    mount_host_results="${mount_host_datasets}/results/${package}"
    mount_container_results=/results/svgenes/${package}

    mkdir -p ${mount_host_results}

    singularity exec --writable-tmpfs --bind ${mount_host_results}:${mount_container_results} --bind ${mount_host_datasets}:${mount_container_dataset} ../singularity/voyager.sif python3 /benchmark/benchmark_svgenes.py -p ${package} -d ${dataset} -l ${libd_sample} -s ${shuffle}
}


if [ $shuffle == "yes" ]
then
   shfl="shuffle"
else
   shfl="normal"
fi


if [ $rep == "rep1" ]
then
   log_path="$PWD/log_${shfl}_filters_${filter_genes_ncounts}_${filter_genes_pcspots}_${rep}"
else
   log_path="$PWD/replicates/log_${shfl}_${filter_genes_ncounts}_${filter_genes_pcspots}/${rep}"
fi

sbatch -o ${log_path}/_slurm-${pckg}-%A.out slurm_execute
