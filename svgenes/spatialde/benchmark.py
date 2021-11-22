#!/usr/bin/env python3
#
# Copyright 2021 Gabriele Sales
# Copyright 2021 Davide Corso
#

import pandas as pd
import NaiveDE
import SpatialDE

import sys
sys.path.insert(1, "/benchmark")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def spatialde_workflow(counts, coords):
    # counts = pd.read_csv('Rep11_MOB_0.csv', index_col=0)
    # sample_info = pd.read_csv('MOB_sample_info.csv', index_col=0)
    sample_info = coords

    counts = counts.T[counts.sum(0) >= 3].T  # Filter practically unobserved genes
    counts = counts.loc[sample_info.index]  # Align count matrix with metadata table

    norm_expr = NaiveDE.stabilize(counts.T).T
    resid_expr = NaiveDE.regress_out(sample_info, norm_expr.T, 'np.log(total_counts)').T

    X = sample_info[['x', 'y']]

    # 100 genes dataset only for run demo
    sample_resid_expr = resid_expr.sample(n=100, axis=1, random_state=1)
    results = SpatialDE.run(X, sample_resid_expr)

    # results = SpatialDE.run(X, resid_expr)

    write_results(results)


args = parse_args()
dataset = args.dataset
ad = load_anndata(dataset)

counts, coords, _ = detach_anndata(ad, symbols=False, transpose_counts=True, coord_on_colnames=False)
spatialde_workflow(counts, coords)
