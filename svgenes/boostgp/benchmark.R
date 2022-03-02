#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

system("ln -sf /repos/BOOST-GP/R .")

source("R/boost.gp.R")
source("/benchmark/utils.R")

boostgp_workflow <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- tokens$counts
    coords <- tokens$coords

    # a count matrix with each row representing one spatial location, and each column representing one gene.

    # Partial dataset
    # counts <- t(counts[1:2, 1:100])

    # Full dataset
    counts <- t(counts)

    coords <- coords[rownames(counts),]
    res <- boost.gp(Y = counts, loc = coords, )

    write_results(res, pckg_name="boostgp", analysis="svgenes")
}

args <- commandArgs(trailingOnly = TRUE)
dataset <- args[1]
libd_sample <- args[2]

spe <- load_SpE(dataset=dataset, libd_sample=libd_sample)
boostgp_workflow(spe)
