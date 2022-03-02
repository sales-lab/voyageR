from argparse import ArgumentParser
import anndata
import numpy as np
import pandas as pd
import _pickle as cPickle


def parse_args():
    parser = ArgumentParser(description='Benchmark python packages')
    parser.add_argument('dataset', help='Choose dataset for TENxVisiumData')
    parser.add_argument('libd_sample', help='Sample ID of spatialLIBD dataset.', 
        choices=["151507", "151508", "151509", "151510", "151669", "151670", "151671", "151672", "151673", "151674", "151675", "151676", "null"])
    return parser.parse_args()


def detach_anndata(ad, symbols=False, transpose_counts=False, coord_on_colnames=False, sep_coord_on_colnames = "x"):
    if symbols:
        # TODO: Fix this section because it may happen that some symbols are duplicated in the data frame. So it is necessary to make symbols unique
        df = ad.to_df().T
        counts = pd.concat([df, ad.var], axis=1)
        counts.set_index("symbol", inplace=True)
        counts.index.name = None
    else:
        counts = ad.to_df().T
    
    counts = counts.astype(np.float64)
    tc = pd.DataFrame(counts.sum(axis=0), columns=["total_counts"])
    
    c = ad.obs
    c.rename(columns={"pxl_col_in_fullres": "x", "pxl_row_in_fullres": "y"}, inplace=True)
    rawcoords = c.loc[:, ["x", "y"]].copy()
    coords = pd.concat([rawcoords, tc], axis=1)
    # locs useful only for same packages
    # locs = np.array([[coords.loc[i].x, coords.loc[i].y] for i in counts.columns])
    
    if coord_on_colnames:
        coord_colnames = [f"{coords.loc[i].x}{sep_coord_on_colnames}{coords.loc[i].y}" for i in counts.columns]
        assert len(counts.columns) == len(coord_colnames)
        counts.columns = coord_colnames

    if transpose_counts:
        counts = counts.T

    assert ad.obs.scaleFactor.nunique() == 1
    sf = ad.obs.iloc[0, list(ad.obs.columns).index("scaleFactor")]

    return counts, coords, sf


def load_anndata(dataset, libd_sample):
    file=f"/benchmark/datasets/SpE_{dataset}_{libd_sample}.h5ad"
    ad = anndata.read_h5ad(file)
    return ad


def write_results(df, pckg_name, analysis, filename="results"):
    path_results = f"/results/{analysis}/{pckg_name}"
    df.to_csv(f"{path_results}/{filename}.csv", header=True, index=False, sep="\t")
    df.to_pickle(f"{path_results}/{filename}.pkl") 
