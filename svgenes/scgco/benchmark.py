#!/usr/bin/env python3
#
# Copyright 2021 Davide Corso
# repo scGCO-commit: https://github.com/WangPeng-Lab/scGCO/tree/0a2d89935b9067f5c31f43e1e2649e505800264b
#

from scGCO import *

import pandas as pd
import numpy as np
from scipy.spatial.distance import cdist

import sys
sys.path.insert(1, "/benchmark")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def scgco_preprocess(counts, num_exp_genes, num_exp_spots, min_expression, drop):
    # Counts --> gene on column and spot on rows

    print('raw data dim: {}'.format(counts.shape))
    num_spots = len(counts.index)
    num_genes = len(counts.columns)
    min_genes_spot_exp = round((counts != 0).sum(axis=1).quantile(num_exp_genes))
    print("Number of expressed genes a spot must have to be kept " \
    "({}% of total expressed genes) {}".format(num_exp_genes, min_genes_spot_exp))
    
    mark_points = np.where((counts != 0).sum(axis=1) < min_genes_spot_exp)[0]
    print("Marked {} spots".format(len(mark_points)))
    
    if len(mark_points)>0:
        noiseInd = [counts.shape[0]-1-i for i in range(len(mark_points))]
        if drop == False:
            temp = [val.split('x') for val in counts.index.values]
            coord = np.array([[float(a[0]), float(a[1])] for a in temp])

            similar_points=np.argsort(cdist(coord[mark_points,:],coord),axis=1)[:,1]
            for i,j in zip(mark_points,similar_points):
                counts.iloc[i,:]=counts.iloc[j,:]
        
            mark_counts=counts.iloc[mark_points,:]
            dropped_counts = counts.drop(counts.index[mark_points])
            counts=pd.concat([dropped_counts,mark_counts])  
            
        else:    
            counts = counts[(counts != 0).sum(axis=1) >= min_genes_spot_exp]
    else:
        counts = counts
        noiseInd =[] 
    
    # Spots are columns and genes are rows
    counts = counts.transpose()
    # Remove noisy genes
    min_features_gene = round(len(counts.columns) * num_exp_spots) 
    print("Removing genes that are expressed in less than {} " \
    "spots with a count of at least {}".format(min_features_gene, min_expression))
    counts = counts[(counts >= min_expression).sum(axis=1) >= min_features_gene]
    print("Dropped {} genes".format(num_genes - len(counts.index)))
    
    temp = [val.split('x') for val in counts.columns.values]
    coord = np.array([[float(a[0]), float(a[1])] for a in temp])
    data=counts.transpose()

    return coord, data, noiseInd


def scgco_workflow(counts, num_exp_genes=0.01, num_exp_spots=0.01, min_expression=1, drop = False):
    locs, data, _ = scgco_preprocess(counts, num_exp_genes=num_exp_genes, num_exp_spots=num_exp_spots, min_expression=min_expression, drop = False)

    # 100 genes dataset only for run demo
    full_data_norm = normalize_count_cellranger(data)
    data_norm = full_data_norm.iloc[:, 0:1000]

    # data_norm = normalize_count_cellranger(data)

    exp = data_norm.iloc[:,0]
    cellGraph = create_graph_with_weight(locs, exp)

    # without parallelization
    gmmDict = gmm_model(data_norm)

    result_df = identify_spatial_genes(locs, data_norm, cellGraph, gmmDict)

    assert "gene" not in list(result_df.columns)
    result_df.reset_index(inplace=True)
    result_df.rename(columns={'index': 'gene'}, inplace=True)
    write_results(result_df)


args = parse_args()
dataset = args.dataset
ad = load_anndata(dataset)

counts, _, _ = detach_anndata(ad, symbols=False, transpose_counts=True, coord_on_colnames=True)

scgco_workflow(counts)
