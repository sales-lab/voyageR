#!/usr/bin/env python3
#
# Copyright 2021 Davide Corso
#

import pandas as pd
import numpy as np
from somde import SomNode
from somde.util import *

import sys
sys.path.insert(1, "../../")
from utils_anndata import parse_args, detach_anndata, load_anndata, write_results


def somde_workflow(counts, coord):
    # countfile = "Rep11_MOB_0.csv"
    # coordfile = "MOB_sample_info.csv"

    # df = pd.read_csv(countfile, sep=",", index_col=0).T
    # coord = pd.read_csv(coordfile, sep=",", index_col=0)
    df = counts

    # 100 genes dataset only for run demo
    df = df.loc[list(df.index)[:100], list(coord.index)]
    
    # df = df.loc[:, list(coord.index)]

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
