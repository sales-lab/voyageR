#!/usr/bin/env python3
#
# Copyright 2021 Davide Corso
#

import pandas as pd
import numpy as np
from somde import SomNode
from somde.util import *

import sys
sys.path.insert(1, "/benchmark")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def somde_workflow(counts, coord):
    df = counts

    # Partial Dataset: 100 genes dataset only for run demo
    # df = df.loc[list(df.index)[:100], list(coord.index)]
    
    # Full dataset
    df = df.loc[:, list(coord.index)]

    X=coord[['x','y']].values.astype(np.float32)

    # Fixed grid layout
    # grid = 21
    # k = df.shape[1] / grid**2
    
    k = 20
    som = SomNode(X,k)

    ndf,ninfo = som.mtx(df)

    nres = som.norm()

    result, SVnum =som.run()
    write_results(result)


args = parse_args()
dataset = args.dataset
ad = load_anndata(dataset)

counts, coords, _ = detach_anndata(ad, symbols=False, transpose_counts=False, coord_on_colnames=False)

somde_workflow(counts, coords)
