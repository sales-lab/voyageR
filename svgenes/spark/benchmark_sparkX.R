#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

library(SPARK)
library(Matrix)
source("/benchmark/utils.R")


sparkx_workflow <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- as(tokens$counts, "dgCMatrix")
    coords <- tokens$coords
    colnames(coords) <- c("x", "y")

    # Partial dataset: 100 genes (partial counts)
    # counts <- counts[1:10, ]

    sink("/dev/null")
    sparkX <- sparkx(counts, coords, numCores=4, option="mixture")
    sink()

    write_results(sparkX$res_mtest, pckg_name="spark", analysis="svgenes", extra_name="_sparkX")
}


args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
sparkx_workflow(spe)
