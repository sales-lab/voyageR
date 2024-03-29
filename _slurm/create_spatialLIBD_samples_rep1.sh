#!/bin/bash


# SPECIFIC SAMPLE
while read dts || [[ -n $dts ]]; do
    IFS=_ read libd_sample shuffle filter_genes_ncounts filter_genes_pcspots rep <<< ${dts}
    echo "spatialLIBD ${libd_sample} ${shuffle} ${filter_genes_ncounts} ${filter_genes_pcspots} ${rep}"
    ./prepare_datasets.sh spatialLIBD ${libd_sample} ${shuffle} ${filter_genes_ncounts} ${filter_genes_pcspots} ${rep}; 
done < specific_spatialLIBD/spatialLIBD_samples_normal_filters_3_01_rep1.txt
