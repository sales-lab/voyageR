#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

library(MERINGUE)
library(Matrix)
source("/benchmark/utils.R")

meringue_workflow <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- tokens$counts
    coords <- tokens$coords
    
    counts <- Matrix::Matrix(counts, sparse = TRUE)

    # remove poor datasets and genes with default parameters
    # counts <- cleanCounts(
    #     counts=counts,
    #     plot=FALSE,
    #     verbose=TRUE
    # )
    
    # CPM normalize
    mat <- MERINGUE::normalizeCounts(counts = counts, 
        log=TRUE,
        verbose=TRUE
    )

    # Get neighbor-relationships
    w <- getSpatialNeighbors(coords, filterDist = 150)
    
    # Identify sigificantly spatially auto-correlated genes
    
    # Partial dataset
    # test <- sample(rownames(mat), 100)
    # I <- getSpatialPatterns(mat[test,], w)

    # Full dataset
    I <- getSpatialPatterns(mat, w)
    
    results.filter <- filterSpatialPatterns(
        mat = mat,
        I = I,
        w = w,
        adjustPv = TRUE,
        alpha = 1,
        minPercentCells = 0.10,
        verbose = TRUE,
        details = TRUE
    )

    ordered_res <- results.filter[order(results.filter$p.adj),]
    write_results(ordered_res, pckg_name="meringue", analysis="svgenes")
}


args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
meringue_workflow(spe)
