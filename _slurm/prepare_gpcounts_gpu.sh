#!/bin/bash
#
# Copyright 2022 Davide Corso
#


base_folder="$PWD/specific_spatialLIBD/gpcounts_gpu"

mkdir -p ${base_folder}

# CP Slurm file of GPCounts 
cp "$PWD/specific_spatialLIBD/gpcounts_slurm.sh" "${base_folder}/"
# Modified copied file
sed -i "s/^samples_file=\$1/#samples_file=\$1/" "${base_folder}/gpcounts_slurm.sh"
sed -i "s/^smpl=\"\$(tail*/smpl=\$1 #\$(tail/" "${base_folder}/gpcounts_slurm.sh"
# sed with different separator syntax
sed -i "s#../singularity/voyager.sif#voyager.sif#g" "${base_folder}/gpcounts_slurm.sh"


# CP samples files
cp "$PWD/specific_spatialLIBD/gpcounts_slurm.sh" "${base_folder}/"

libd_samples="${base_folder}/libd_samples"

mkdir -p ${libd_samples}

cp specific_spatialLIBD/spatialLIBD_samples_*_rep1.txt "${libd_samples}/"

cp specific_spatialLIBD/replicates/spatialLIBD_samples_*_rep2.txt "${libd_samples}/"
cp specific_spatialLIBD/replicates/spatialLIBD_samples_*_rep3.txt "${libd_samples}/"
cp specific_spatialLIBD/replicates/spatialLIBD_samples_*_rep4.txt "${libd_samples}/"
cp specific_spatialLIBD/replicates/spatialLIBD_samples_*_rep5.txt "${libd_samples}/"


# DATASETS
## R files
for file in $( ls -- datasets_and_results/*rep[1-5]/**/*.rds ) 
do	
    cp --parents "${file}" "${base_folder}/"
done
## Python files
for file in $( ls -- datasets_and_results/*rep[1-5]/**/*.h5ad ) 
do	
    cp --parents "${file}" "${base_folder}/"
done


# Creating execute file
execute_file="${base_folder}/execute_this.sh"

if [[ -f $execute_file ]]
then
    rm ${execute_file}
fi

touch ${execute_file}

cat <<EOT >> ${execute_file}
#!/bin/bash
#
# Copyright 2022 Davide Corso
#

ls libd_samples/spatialLIBD_samples_*.txt \\
    | while read file; 
do	
    cat \${file} | while read line || [[ -n \$line ]];
    do
        echo \"\${line}\"
        bash gpcounts_slurm.sh \${line}
    done
done

echo 'FINISHED'
EOT

chmod u+x ${execute_file}

cp singularity/voyager.sif "${base_folder}/"
 