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

    output_folder = f"/results/svgenes/{package}"
    dir=f"/benchmark/svgenes/{package}"

    if not path.isdir(dir):
        print(f"Error: package '{package}' not found.")
        exit(1)

    if dataset != "spatialLIBD":
        libd_sample = "null"

    file=f"/benchmark/datasets/SpE_{dataset}_{libd_sample}.h5ad"
    if not path.isfile(file):
        # Changing Working Directory
        print(f"{file} not available")
        exit(1)

    check_call(["mkdir", "-p", output_folder])
    chdir(output_folder)
    execute_command = f"bash /benchmark/svgenes/_execute/{package}.sh {dataset} {libd_sample}"
    check_call(execute_command, shell=True)


def parse_args():
    parser = ArgumentParser(description="")
    parser.add_argument('--package', '-p', help='Package. Required', required=True)
    parser.add_argument('--dataset', '-d', help='SpatialLIBD or 10xVisium dataset from TENxVisiumData Bioconductor package. Required.', 
        required=True)
    parser.add_argument('--libd_sample', '-l', help='Sample ID of spatialLIBD dataset. Put null if dataset != spatialLIBD (-l null).', 
        required=True, type=str,
        choices=["151507", "151508", "151509", "151510", "151669", "151670", "151671", "151672", "151673", "151674", "151675", "151676", "null"])
    return parser.parse_args()


if __name__ == "__main__":
    main()
