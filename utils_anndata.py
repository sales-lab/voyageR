from argparse import ArgumentParser
import anndata
import numpy as np
import pandas as pd


def parse_args():
    parser = ArgumentParser(description='Benchmark python packages')
    parser.add_argument('dataset', help='Choose dataset for TENxVisiumData')
    return parser.parse_args()


def detach_anndata(ad, symbols=False, transpose_counts=False, coord_on_colnames=False, sep_coord_on_colnames = "x"):
    if symbols:
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


def load_anndata(dataset):
    ad = anndata.read_h5ad(f"../../datasets/SpE_{dataset}.h5ad")
    return ad


def write_results(df, filename="results.csv"):
    df.to_csv(filename, header=True, index=False, sep="\t")
