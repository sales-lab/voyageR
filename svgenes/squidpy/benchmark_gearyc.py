#!/usr/bin/env python3
#
# Copyright 2022 Davide Corso
#

import scanpy as sc
import squidpy as sq
import pandas as pd
from anndata import AnnData

import sys
sys.path.insert(1, "/benchmark")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def squidpy_workflow(counts, coords):
    # Fonte 1: https://github.com/theislab/anndata/blob/33006dc75b6ceaedaf262f4ec5c9d1f3c55700a9/anndata/_core/anndata.py#L435
    # Fonte 2: https://scanpy.readthedocs.io/en/stable/usage-principles.html#anndata
    # Fonte 3: https://scanpy-tutorials.readthedocs.io/en/latest/spatial/basic-analysis.html#MERFISH-example
    coordinates = coords.loc[:, ["x", "y"]].copy().to_numpy()
    adata = AnnData(counts, obsm={"spatial": coordinates})
    
    sc.pp.normalize_total(adata)
    sc.pp.log1p(adata)

    sq.gr.spatial_neighbors(adata)

    sq.gr.spatial_autocorr(
        adata,
        mode="geary",
        n_perms=1000,
        n_jobs=4,
    )
    
    # Genes have already been sorted by Geary’s C statistic (Geary's C is inversely related to Moran's I).
    results = adata.uns["gearyC"]
    results["genes"] = results.index

    write_results(results, pckg_name="squidpy", analysis="svgenes", filename="results_gearyC")


args = parse_args()
base_file = args.base_file
ad = load_anndata(base_file)

counts, coords, _ = detach_anndata(ad, symbols=False, transpose_counts=True, coord_on_colnames=False)
squidpy_workflow(counts, coords)
