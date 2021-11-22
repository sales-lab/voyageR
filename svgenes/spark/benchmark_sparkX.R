#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

library(SPARK)
library(Matrix)
source("../../utils.R")


sparkx_workflow <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- as(tokens$counts, "dgCMatrix")
    coords <- tokens$coords
    colnames(coords) <- c("x", "y")

    # 100 genes (partial counts)
#     counts <- counts[1:10, ]

    sink("/dev/null")
    sparkX <- sparkx(counts, coords, numCores=4, option="mixture")
    sink()

    write_results(sparkX$res_mtest, extra_name="_sparkX")
}


args <- commandArgs(trailingOnly = TRUE)
dataset <- args[1]

spe <- load_SpE(dataset=dataset)
sparkx_workflow(spe)
