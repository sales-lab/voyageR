#!/usr/bin/env Rscript
#
# Copyright 2022 Davide Corso
#

library(nnSVG)
library(scran)
source("/benchmark/utils.R")

set.seed(42)

nnsvg_workflow <- function(spe) {
    qclus <- quickCluster(spe)
    spe <- computeSumFactors(spe, cluster = qclus)
    spe <- logNormCounts(spe)

    spe <- nnSVG(spe, n_threads = 4)

    results <- as.data.frame(rowData(spe))

    write_results(results, pckg_name="nnsvg", analysis="svgenes")
}


args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
nnsvg_workflow(spe)
