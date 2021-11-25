#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

library(MERINGUE)
source("/benchmark/utils.R")

meringue_workflow <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- tokens$counts
    coords <- tokens$coords

    # CPM normalize
    mat <- normalizeCounts(counts = counts, 
        log=FALSE,
        verbose=TRUE
    )

    # Get neighbor-relationships
    w <- getSpatialNeighbors(coords, filterDist = 25)
    
    # Identify sigificantly spatially auto-correlated genes
    
    # Partial dataset
    # test <- sample(rownames(mat), 100)
    # I <- getSpatialPatterns(mat[test,], w)

    I <- getSpatialPatterns(mat, w)
    
    results.filter <- filterSpatialPatterns(
        mat = mat[test,],
        I = I,
        w = w,
        adjustPv = TRUE,
        alpha = 0.05,
        minPercentCells = 0.05,
        verbose = TRUE,
        details = TRUE
    )

    ordered_res <- results.filter[order(results.filter$p.adj),]
    write.table(ordered_res, file = "results.csv", quote = FALSE, sep="\t", row.names = T, col.name = NA)
}


args <- commandArgs(trailingOnly = TRUE)
dataset <- args[1]

spe <- load_SpE(dataset=dataset)
meringue_workflow(spe)
