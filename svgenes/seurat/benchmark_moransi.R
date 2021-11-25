#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#


library(Seurat)
source("/benchmark/utils.R")
source("/benchmark/spe2seurat.R")

moransi_workflow <- function(seurat_object) {
    seurat_object <- SCTransform(seurat_object, assay = "Spatial", verbose = FALSE)

    # Partial dataset: 100 genes dataset only for run demo
    # seurat_object <- FindSpatiallyVariableFeatures(
        # seurat_object, 
        # assay = "SCT", 
        # features = VariableFeatures(seurat_object)[1:100], 
        # selection.method = "moransi"
    # )

    # Full dataset
    seurat_object <- FindSpatiallyVariableFeatures(
        seurat_object, 
        assay = "SCT", 
        features = VariableFeatures(seurat_object),
        selection.method = "moransi"
    )

    result <- SpatiallyVariableFeatures(seurat_object, selection.method = "moransi")

    write_results(result, extra_name="_moransi")
}


args <- commandArgs(trailingOnly = TRUE)
dataset <- args[1]

se1 <- spe2seurat(dataset=dataset)
moransi_workflow(se1)
