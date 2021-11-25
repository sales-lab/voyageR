#!/usr/bin/env python3
#
# Copyright 2021 Davide Corso
#

import sys
import pandas as pd
import numpy as np
from statsmodels.stats.multitest import fdrcorrection

import os
nthreads = 4
os.environ["MKL_NUM_THREADS"] = str(nthreads)
os.environ["NUMEXPR_NUM_THREADS"] = str(nthreads)
os.environ["OMP_NUM_THREADS"] = str(nthreads)

sys.path.insert(1, '/repos/JSTA/CoreFunctions/')
from FindSpatialDEGs import *

sys.path.insert(1, "/benchmark")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def jsta_workflow(counts, coords):
    counts = counts.loc[coords.index]
    locs = np.array([[coords.loc[i].x, coords.loc[i].y] for i in counts.index])
    counts.reset_index(inplace=True, drop=True)

    # Partial dataset
    counts = counts.iloc[:, :5]

    nneighbors = 10
    nperm = 1000

    ps_vec = get_spatial_pval(
        cells_mat = counts,
        celltypes = np.array(['cts' for i in range(counts.shape[0])]),
        cell_cent = locs,
        ct = 'cts', 
        nneighbors = nneighbors,
        nperm = nperm
    )
    genes = counts.columns
    pvals_gene_list = []
    for pval, gene_index in ps_vec:
        pvals_gene_list.append([pval, genes[gene_index]])
    
    fdrs = fdrcorrection([i[0] for i in pvals_gene_list], alpha=0.05, method='indep', is_sorted=False)[1]
    results = pd.DataFrame([[fdrs[i], pvals_gene_list[i][1]] for i in range(len(fdrs))], columns=["adjusted_pvalue", "gene"])
    write_results(results)


args = parse_args()
dataset = args.dataset
ad = load_anndata(dataset)

counts, coords, _ = detach_anndata(ad, symbols=False, transpose_counts=True, coord_on_colnames=False)

jsta_workflow(counts, coords)
