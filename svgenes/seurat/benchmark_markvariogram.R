#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#


library(Seurat)
library(bench)
source("../../utils.R")
source("../../spe2seurat.R")

markvariogram_workflow <- function(seurat_object) {
    seurat_object <- SCTransform(seurat_object, assay = "Spatial", verbose = FALSE)

    # 100 genes dataset only for run demo
    seurat_object <- FindSpatiallyVariableFeatures(
        seurat_object, 
        assay = "SCT", 
        features = VariableFeatures(seurat_object), # [1:100], 
        selection.method = "markvariogram"
    )

    result <- SpatiallyVariableFeatures(seurat_object, selection.method = "markvariogram")

    write_results(result, extra_name="_markvariogram")
}

args <- commandArgs(trailingOnly = TRUE)
dataset <- args[1]

se1 <- spe2seurat(dataset=dataset)
markvariogram_workflow(se1)
