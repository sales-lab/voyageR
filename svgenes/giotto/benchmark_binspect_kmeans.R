#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#
# Spatially Variable Genes with BinSpect (kmeans and rank)
# 10x Mouse brain coronal workflow here: http://spatialgiotto.rc.fas.harvard.edu/giotto.visium.brain.html
#

library(Giotto)
source("/benchmark/utils.R")

giotto_workflow_binspect_kmeans <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- tokens$counts
    coords <- tokens$coords

    workdir <- "."

    instructions <- createGiottoInstructions(
        show_plot = F,
        return_plot = F,
        save_plot = F,
        save_dir = workdir
    )

    mbrain <- createGiottoObject(raw_exprs = counts, spatial_locs = coords, instructions = instructions )

    ## filter genes and cells
    mbrain <- filterGiotto(gobject = mbrain, expression_threshold = 1, gene_det_in_min_cells = 50,
                        min_det_genes_per_cell = 1000, expression_values = c('raw'),verbose = T)

    ## normalize
    mbrain <- normalizeGiotto(gobject = mbrain, scalefactor = 6000, verbose = T)

    # Partial Dataset: 10 genes dataset only for run demo
    # demo_genes <- slot(mbrain, 'gene_ID')[1:100]
    # mbrain <- subsetGiotto(mbrain, gene_ids = demo_genes)

    # create network (required for binSpect methods)
    mbrain <- createSpatialNetwork(gobject = mbrain, method = 'kNN', k = 5, maximum_distance_knn = 400, name = 'spatial_network')

    km_spatialgenes <- binSpect(mbrain, calc_hub = T, hub_min_int = 5,spatial_network_name = 'spatial_network')
    km_spatialgenes <- km_spatialgenes[order(km_spatialgenes$adj.p.value), ]
    write_results(km_spatialgenes, pckg_name="giotto", analysis="svgenes", extra_name="_binSpect_kmeans")
}


args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
giotto_workflow_binspect_kmeans(spe)
