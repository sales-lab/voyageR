#!/usr/bin/env python3
#

import pandas as pd
import os
import numpy
from statsmodels.stats.multitest import fdrcorrection


os.system("mkdir -p results/svgenes/boostgp_combined")
os.system("mkdir -p results/svgenes/giotto_combined")
os.system("mkdir -p results/svgenes/gliss_combined")
os.system("mkdir -p results/svgenes/gpcounts_combined")
os.system("mkdir -p results/svgenes/jsta_combined")
os.system("mkdir -p results/svgenes/meringue_combined")
os.system("mkdir -p results/svgenes/rayleighselection_combined")
os.system("mkdir -p results/svgenes/scgco_combined")
os.system("mkdir -p results/svgenes/seurat_combined")
os.system("mkdir -p results/svgenes/singlecellhaystack_combined")
os.system("mkdir -p results/svgenes/somde_combined")
os.system("mkdir -p results/svgenes/spark_combined")
os.system("mkdir -p results/svgenes/spatialde_combined")
os.system("mkdir -p results/svgenes/stutility_combined")

def write_combined_fdr(rawdf, colname_genes, colname_adjpval, package, method=None, log_pvalue=False, p_thr=1):
    df = rawdf.loc[:, [colname_genes, colname_adjpval]]
    if not log_pvalue:
        df.rename(columns={colname_genes: 'genes', colname_adjpval: 'adj_pvalue'}, inplace=True)

        df.drop_duplicates(inplace=True)

        for i in df["adj_pvalue"]:
            assert isinstance(i, float)

        x = df[df["adj_pvalue"] < p_thr]
        y = x.sort_values(by="adj_pvalue", ascending=True)
    else:
        df.rename(columns={colname_genes: 'genes', colname_adjpval: 'log_adj_pvalue'}, inplace=True)
        df.drop_duplicates(inplace=True)
        for i in df["log_adj_pvalue"]:
            assert isinstance(i, float)

        x = df[df["log_adj_pvalue"] < numpy.log10(p_thr)]
        y = x.sort_values(by="log_adj_pvalue", ascending=True)

    if method is None:
        filename =  f"results/svgenes/{package}_combined/voyager_fdr.csv"
    else:
        filename =  f"results/svgenes/{package}_combined/voyager_fdr_{method}.csv"

    y.to_csv(filename, header=True, index=False, sep="\t")


def write_combined_score(rawdf, colname_genes, colname_score, package, method=None, p_thr=1):
    df = rawdf.loc[:, [colname_genes, colname_score]]

    df.rename(columns={colname_genes: 'genes', colname_score: 'score'}, inplace=True)
    df.drop_duplicates(inplace=True)

    for i in df["score"]:
        assert isinstance(i, float)

    x = df[df["score"] < p_thr]
    y = x.sort_values(by="score", ascending=False)
    if method is None:
        filename =  f"results/svgenes/{package}_combined/voyager_score.csv"
    else:
        filename =  f"results/svgenes/{package}_combined/voyager_score_{method}.csv"

    y.to_csv(filename, header=True, index=False, sep="\t")


def write_combined_rank(rawdf, colname_genes, colname_rank, package, method=None):
    df = rawdf.loc[:, [colname_genes, colname_rank]]

    df.rename(columns={colname_genes: 'genes', colname_rank: 'rank'}, inplace=True)
    df.drop_duplicates(inplace=True)

    for i in df["rank"]:
        assert isinstance(i, int)

    y = df.sort_values(by="rank", ascending=True)
    if method is None:
        filename =  f"results/svgenes/{package}_combined/voyager_rank.csv"
    else:
        filename =  f"results/svgenes/{package}_combined/voyager_rank_{method}.csv"

    y.to_csv(filename, header=True, index=False, sep="\t")


# boostgp = pd.read_table("./results/svgenes/boostgp/")
fdr_thr = 1
giotto1 = pd.read_table("results/svgenes/giotto/results_binSpect_kmeans.csv")
write_combined_fdr(giotto1, colname_genes="genes", colname_adjpval="adj.p.value", package="giotto", method="binSpect_kmeans", p_thr=fdr_thr)

giotto2 = pd.read_table("results/svgenes/giotto/results_binSpect_rank.csv")
write_combined_fdr(giotto2, colname_genes="genes", colname_adjpval="adj.p.value", package="giotto", method="binSpect_rank", p_thr=fdr_thr)

giotto3 = pd.read_table("results/svgenes/giotto/results_silhouette.csv")
write_combined_score(giotto3, colname_genes="genes", colname_score="scores", package="giotto", method="silhouette")

gliss = pd.read_table("results/svgenes/gliss/results.csv")
fdrs = fdrcorrection([i for i in gliss.pvalue], alpha=0.01, method='indep', is_sorted=False)
gliss["fdr"] = fdrs[1]
#gliss = gliss[gliss["reject"] == True]
write_combined_fdr(gliss, colname_genes="geneID", colname_adjpval="fdr", package="gliss", method=None, p_thr=fdr_thr)

# gpcounts = pd.read_table("./results/svgenes/gpcounts/")

# jsta = pd.read_table("./results/svgenes/jsta/")

# meringue = pd.read_table("./results/svgenes/meringue/")

raysel = pd.read_table("./results/svgenes/rayleighselection/results.csv")
write_combined_fdr(raysel, colname_genes="Unnamed: 0", colname_adjpval="q0", package="rayleighselection", method=None, p_thr=fdr_thr)

scgco = pd.read_table("results/svgenes/scgco/results.csv")
write_combined_fdr(scgco, colname_genes="gene", colname_adjpval="fdr", package="scgco", method=None, p_thr=fdr_thr)

seurat1 = pd.read_table("results/svgenes/seurat/results_markvariogram.csv")
seurat1 = seurat1[seurat1["markvariogram.spatially.variable"] == True]
write_combined_rank(seurat1, colname_genes="Unnamed: 0", colname_rank="markvariogram.spatially.variable.rank", package="seurat", method="markvariogram")

seurat2 = pd.read_table("results/svgenes/seurat/results_moransi.csv")
seurat2 = seurat2[seurat2["moransi.spatially.variable"] == True]
write_combined_fdr(seurat2, colname_genes="Unnamed: 0", colname_adjpval="adj.pvalue", package="seurat", method="moransi", p_thr=fdr_thr)

sch = pd.read_table("results/svgenes/singlecellhaystack/results.csv")
write_combined_fdr(sch, colname_genes="gene", colname_adjpval="log.p.adj", package="singlecellhaystack", method=None, log_pvalue=True, p_thr=fdr_thr)

somde = pd.read_table("results/svgenes/somde/results.csv")
write_combined_fdr(somde, colname_genes="g", colname_adjpval="qval", package="somde", method=None, log_pvalue=False, p_thr=fdr_thr)

spark1 = pd.read_table("results/svgenes/spark/results_spark.csv")
write_combined_fdr(spark1, colname_genes="Unnamed: 0", colname_adjpval="adjusted_pvalue", package="spark", method="spark", p_thr=fdr_thr)

spark2 = pd.read_table("results/svgenes/spark/results_sparkX.csv")
write_combined_fdr(spark2, colname_genes="Unnamed: 0", colname_adjpval="adjustedPval", package="spark", method="sparkX", p_thr=fdr_thr)

spatialde = pd.read_table("results/svgenes/spatialde/results.csv")
write_combined_fdr(spatialde, colname_genes="g", colname_adjpval="qval", package="spatialde", method=None, p_thr=fdr_thr)
