#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

system("ln -sf /repos/BOOST-GP/R .")

source("R/boost.gp.R")
source("../../utils.R")

boostgp_workflow <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- tokens$counts
    coords <- tokens$coords

    # a count matrix with each row representing one spatial location, and each column representing one gene.
    # counts <- t(counts[1:2, 1:100])

    counts <- t(counts)
    coords <- coords[rownames(counts),]

    res <- boost.gp(Y = counts, loc = coords, )

    write_results(res)
}

args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) == 1)
dataset <- args[1]

spe <- load_SpE(dataset=dataset)
boostgp_workflow(spe)
