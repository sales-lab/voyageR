#!/bin/bash

# rm datasets_and_results/**/spatialLIBD_*.rds
# rm datasets_and_results/**/spatialLIBD_*.h5ad


while read dts; do
    IFS=_ read libd_sample shuffle filter_genes_ncounts filter_genes_pcspots <<< ${dts}
    echo "spatialLIBD ${libd_sample} ${shuffle} ${filter_genes_ncounts} ${filter_genes_pcspots}"
    ./prepare_datasets.sh spatialLIBD ${libd_sample} ${shuffle} ${filter_genes_ncounts} ${filter_genes_pcspots} ; 
done < specific_spatialLIBD/spatialLIBD_samples_filters.txt
