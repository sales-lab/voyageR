#!/usr/bin/env python3
#
# Copyright 2021 Davide Corso
# repo gliss-commit: https://github.com/junjiezhujason/gliss/tree/b69ee1f135b2f571975d66034b8e911f733f5c4b
#

import sys

sys.path.insert(0, '/repos/gliss/src')
from general_utils import normalize_count_cellranger
from main_methods import select_spatial_genes
import pandas as pd
import numpy as np

sys.path.insert(1, "/benchmark")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def gliss_preprocess(counts, num_exp_genes=0.01, num_exp_spots=0.01, min_expression=1):
    num_spots = len(counts.index)
    num_genes = len(counts.columns)
    min_genes_spot_exp = round((counts != 0).sum(axis=1).quantile(num_exp_genes))
    #     print("Number of expressed genes a spot must have to be kept " \
    #     "({}% of total expressed genes) {}".format(num_exp_genes, min_genes_spot_exp))
    counts = counts[(counts != 0).sum(axis=1) >= min_genes_spot_exp]
    #     print("Dropped {} spots".format(num_spots - len(counts.index)))
          
    # Spots are columns and genes are rows
    counts = counts.transpose()
  
    # Remove noisy genes
    min_features_gene = round(len(counts.columns) * num_exp_spots) 
    #     print("Removing genes that are expressed in less than {} " \
    #     "spots with a count of at least {}".format(min_features_gene, min_expression))
    counts = counts[(counts >= min_expression).sum(axis=1) >= min_features_gene]
    #     print("Dropped {} genes".format(num_genes - len(counts.index)))
    
    data=counts.transpose()
    temp = [val.split('x') for val in data.index.values]
    coord = np.array([[float(a[0]), float(a[1])] for a in temp])

    return coord, data


def gliss_workflow(rawcounts, num_exp_genes=0.01, num_exp_spots=0.01, min_expression=1):
    # counts: gene on columns and spot on rows
    # locs: numpy array with x and y coordinates

    locs, counts = gliss_preprocess(rawcounts, num_exp_genes=num_exp_genes, num_exp_spots=num_exp_spots, min_expression=min_expression)

    # Partial dataset: 100 genes dataset only for run demo
    # full_data_norm = normalize_count_cellranger(counts)
    # data_norm = full_data_norm.iloc[:, :100]

    # Full dataset
    data_norm = normalize_count_cellranger(counts)

    alpha = 0.01 # FDR Level
    n_perm = 100000 # number of permutation for p-values

    # run SV gene selection with GLISS
    pvals, rej_idx = select_spatial_genes(locs, data_norm.values, alpha=alpha, n_perm=n_perm)
    
    reject = np.array([False] * len(pvals))
    reject[rej_idx] = True
    result = pd.DataFrame({'pvalue': pvals, 'reject': reject, 'geneID':data_norm.columns}, index=data_norm.columns)
    write_results(result, pckg_name="gliss", analysis="svgenes")


args = parse_args()
dataset = args.dataset
ad = load_anndata(dataset)

counts, _, _ = detach_anndata(ad, symbols=False, transpose_counts=True, coord_on_colnames=True)

gliss_workflow(counts)
