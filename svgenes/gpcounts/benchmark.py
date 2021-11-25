#!/usr/bin/env python3
#
# Copyright 2021 Davide Corso
#

import pandas as pd
import numpy as np
#import gpflow
import tensorflow as tf
from GPcounts import NegativeBinomialLikelihood
from GPcounts.GPcounts_Module import Fit_GPcounts
from matplotlib import pyplot as plt
import statsmodels.formula.api as smf
import statsmodels.api as sm
import warnings
from tqdm import tqdm
warnings.filterwarnings('ignore')

import sys
sys.path.insert(1, "/benchmark")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def gpcounts_workflow(counts):
    # Y is the spatial expression count matrix. Genes on column and coords on rows

    # Y = pd.read_csv('Rep11_MOB_0.csv', index_col=[0])
    Y = counts
    Y = Y.T[Y.sum(0) >= 3].T # Filter out genes with less than 3 total counts

    spatial_locations = pd.DataFrame(index=Y.index)
    spatial_locations['x'] = Y.index.str.split('x').str.get(0).map(float)
    spatial_locations['y'] = Y.index.str.split('x').str.get(1).map(float)

    spatial_locations['total_counts'] = Y.sum(1)
    Y = Y.loc[spatial_locations.index]
    X = spatial_locations[['x', 'y']]

    scales = []
    for i in tqdm(range(0,len(Y.columns))):
        model=smf.glm(
            formula = "Y.iloc[:,i]~0+spatial_locations['total_counts']", 
            data = Y,
            family = sm.families.NegativeBinomial(sm.families.links.identity())
        ).fit()
        res = model.params[0]*spatial_locations['total_counts']
        scales.append(res)
    scalesdf=pd.DataFrame(scales)
    scalesdf=scalesdf.T

    Y = Y.T
    
    # Partial dataset: 10 genes dataset only for run demo
    Y_run = Y.iloc[0:1,:]

    # Full dataset
    # Y_run = Y

    X = X[['x', 'y']]

    gene_name = []
    nb_scaled = True # set the nb_scaled argument to True to pass the scale factors 
    gene_name = Y_run.index
    likelihood = 'Negative_binomial'
    gp_counts = Fit_GPcounts(X, Y_run.loc[gene_name], scale = scalesdf, nb_scaled = nb_scaled, safe_mode = False)

    log_likelihood_ratio = gp_counts.One_sample_test(likelihood)
    results = gp_counts.calculate_FDR(log_likelihood_ratio)
    results['gene'] = results.index
    write_results(results)


args = parse_args()
dataset = args.dataset
ad = load_anndata(dataset)

counts, _, _ = detach_anndata(ad, symbols=False, transpose_counts=True, coord_on_colnames=True)

gpcounts_workflow(counts)
