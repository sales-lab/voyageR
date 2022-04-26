#!/usr/bin/env python3
#
# Copyright 2021 Davide Corso
#

from argparse import ArgumentParser
from os import path, chdir
from subprocess import check_call


def main():
    args = parse_args()

    package = args.package
    dataset = args.dataset
    libd_sample = str(args.libd_sample)
    shuffle = args.shuffle
    filter_genes_ncounts = str(args.filter_genes_ncounts)
    filter_genes_pcspots = str(args.filter_genes_pcspots)

    output_folder = f"/results/svgenes/{package}"
    dir=f"/benchmark/svgenes/{package}"

    if not path.isdir(dir):
        print(f"Error: package '{package}' not found.")
        exit(1)

    if dataset != "spatialLIBD":
        libd_sample = "null"

    if shuffle == "yes":
        base_file = f"/benchmark/datasets/spe_{dataset}_{libd_sample}_shuffled_{filter_genes_ncounts}_{filter_genes_pcspots}"
    else:
        base_file = f"/benchmark/datasets/spe_{dataset}_{libd_sample}"
    
    file_r=f"{base_file}.rds"
    file_py=f"{base_file}.h5ad"
    
    if not path.isfile(file_r):
        # Changing Working Directory
        print(f"{file_r} R file not found")
        exit(1)
    
    if not path.isfile(file_py):
        # Changing Working Directory
        print(f"{file_py} Python file not found")
        exit(1)

    check_call(["mkdir", "-p", output_folder])
    chdir(output_folder)
    execute_command = f"bash /benchmark/svgenes/_execute/{package}.sh {base_file}"
    check_call(execute_command, shell=True)


def parse_args():
    parser = ArgumentParser(description="")
    parser.add_argument('--package', '-p', help='Package. Required', 
        required=True, type=str)
    parser.add_argument('--dataset', '-d', help='SpatialLIBD or 10xVisium dataset from TENxVisiumData Bioconductor package. Required.', 
        required=True, type=str)
    parser.add_argument('--libd_sample', '-l', help='Sample ID of spatialLIBD dataset. null if dataset != spatialLIBD (-l null).', 
        required=True, type=str,
        choices=["151507", "151508", "151509", "151510", "151669", "151670", "151671", "151672", "151673", "151674", "151675", "151676", "null"])
    parser.add_argument('--shuffle', '-s', help='Shuffle coordinates on spatial experiment object',
        required=True, type=str, choices=["yes", "no"])
    parser.add_argument('--filter_genes_ncounts', '-f1', help='Filtering retains genes containing at least this expression counts',
        required=True, type=str)
    parser.add_argument('--filter_genes_pcspots', '-f2', help='Percent of the total number of spatial locations (spots)',
        required=True, type=str)
    return parser.parse_args()


if __name__ == "__main__":
    main()
