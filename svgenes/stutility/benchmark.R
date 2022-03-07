#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

library(STutility)
library(spdep)
source("/benchmark/utils.R")
source("/benchmark/spe2seurat.R")

# Note: there is no line for Partial dataset


stutility_workflow <- function(seurat_object){
    seurat_object <- LoadImages(seurat_object, time.resolve = FALSE, verbose = TRUE)

    seurat_object <- SCTransform(seurat_object)

    results <- CorSpatialGenes(seurat_object)

    write_results(results, pckg_name="stutility", analysis="svgenes")
}


args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
se1 <- spe2seurat(spe)
stutility_workflow(se1)
