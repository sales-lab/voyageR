#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#


library(RayleighSelection)
source("/benchmark/utils.R")

rayleighselection_workflow <- function(spe){
    tokens <- detach_SpE(spe)
    counts <- tokens$counts
    coords <- tokens$coords

    # 10 genes and 100 cells
    # counts <- t(counts[1:10, 1:10])

    counts <- t(counts)
    cells <- rownames(counts)

    data_tpm <- t(counts/rowSums(counts))
    data_tpm[is.na(data_tpm)] <- 0
    data_tpm <- log2(1+data_tpm)

    di <- as.matrix(dist(coords[cells, spatialCoordsNames(spe)]))

    #' Generates a Vietoris-Rips complex from a distance matrix.
    gg <- vr_complex(di, median(di), clique = FALSE)

    # Partial dataset
    # results <- rayleigh_selection(gg, data_tpm[, row.names(di)], num_perms = 10, num_cores = 2, one_forms = FALSE)

    # Full dataset
    results <- rayleigh_selection(gg, data_tpm[, row.names(di)], num_perms = 1000, num_cores = 4, one_forms = FALSE)

    write_results(results, pckg_name="rayleighselection", analysis="svgenes")
}


args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
rayleighselection_workflow(spe)
