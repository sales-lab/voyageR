#!/bin/bash

# ls specific_spatialLIBD/replicates/spatialLIBD_samples_*.txt \
ls specific_spatialLIBD/spatialLIBD_samples_*.txt \
    | while read file; 
do	
    cat ${file} | while read line || [[ -n $line ]];
    do
        IFS=_ read libd_sample shuffle filter_genes_ncounts filter_genes_pcspots rep <<< ${line}
        echo "spatialLIBD ${libd_sample} ${shuffle} ${filter_genes_ncounts} ${filter_genes_pcspots} ${rep}"
        ./prepare_datasets.sh spatialLIBD ${libd_sample} ${shuffle} ${filter_genes_ncounts} ${filter_genes_pcspots} ${rep} ; 
    done
done
