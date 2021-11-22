#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#
# Spatially Variable Genes with Silhouette
# 10x Mouse brain coronal workflow here: http://spatialgiotto.rc.fas.harvard.edu/giotto.visium.brain.html
#

library(Giotto)
library(bench)
source("../../utils.R")

giotto_workflow <- function(spe) {
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

    # 10 genes dataset only for run demo
    # demo_genes <- slot(mbrain, 'gene_ID')[1:100]
    # mbrain <- subsetGiotto(mbrain, gene_ids = demo_genes)

    sil_spatialgenes <- silhouetteRank(gobject = mbrain, expression_values = 'normalized')
    sil_spatialgenes <- sil_spatialgenes[order(sil_spatialgenes$scores, decreasing = T), ]

    write_results(sil_spatialgenes, extra_name="_silhouette")
}


args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) == 1)
dataset <- args[1]

spe <- load_SpE(dataset=dataset)
giotto_workflow(spe)
