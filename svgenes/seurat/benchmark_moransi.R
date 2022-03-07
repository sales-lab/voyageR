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

    result <- seurat_object[["SCT"]]@meta.features
    result <- result[complete.cases(result), ]
    result <- result[order(result$MoransI_p.value), ]
    result$adj.pvalue <- p.adjust(result$MoransI_p.value, "BH")
    result <- result[order(result$adj.pvalue), ]

    write_results(result, pckg_name="seurat", analysis="svgenes", extra_name="_moransi")
}


args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
se1 <- spe2seurat(spe)
moransi_workflow(se1)
