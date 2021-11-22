#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

library(STutility)
library(spdep)
library(bench)
source("../../utils.R")
source("../../spe2seurat.R")

stutility_workflow <- function(seurat_object){
    seurat_object <- LoadImages(seurat_object, time.resolve = FALSE, verbose = TRUE)

    seurat_object <- SCTransform(seurat_object)

    results <- CorSpatialGenes(seurat_object)

    write_results(results)
}


args <- commandArgs(trailingOnly = TRUE)
dataset <- args[1]

se1 <- spe2seurat(dataset=dataset)
stutility_workflow(se1)
