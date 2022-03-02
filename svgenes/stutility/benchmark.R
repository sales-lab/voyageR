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
dataset <- args[1]
libd_sample <- args[2]

spe <- load_SpE(dataset=dataset, libd_sample=libd_sample)
se1 <- spe2seurat(spe)
stutility_workflow(se1)
