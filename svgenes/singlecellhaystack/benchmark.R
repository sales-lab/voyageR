#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#
# Spatially Variable Genes with SingleCellHaystack
#

library(Seurat)
library(singleCellHaystack)
source("/benchmark/utils.R")
source("/benchmark/spe2seurat.R")

set.seed(1)

# Note: there is no line for Partial dataset

singleCellHaystack_workflow <- function(seurat_object) {
	counts <- GetAssayData(seurat_object, slot = "counts")
	sel.ok <- Matrix::rowSums(counts > 1) > 10

	seurat_object <- seurat_object[sel.ok, ]

	seurat_object <- NormalizeData(seurat_object)

	coord <- GetTissueCoordinates(seurat_object)#, "Spatial")
	counts <- GetAssayData(seurat_object, slot = "data")

	res <- haystack_2D(coord$imagecol, coord$imagerow, detection = as.matrix(counts > 1))

	results <- show_result_haystack(res)
	results$gene <- row.names(results)

	write_results(results, pckg_name="singlecellhaystack", analysis="svgenes")
}


args <- commandArgs(trailingOnly = TRUE)
dataset <- args[1]

se1 <- spe2seurat(dataset=dataset)
singleCellHaystack_workflow(se1)
