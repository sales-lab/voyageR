#!/usr/bin/env Rscript
#
# Copyright 2021 Davide Corso
#

library(SPARK)
source("/benchmark/utils.R")


spark_workflow <- function(spe) {
    tokens <- detach_SpE(spe)
    counts <- tokens$counts
    coords <- tokens$coords

    # Partial dataset: 100 genes (partial counts)
    # counts <- counts[1:10, ]

    spark <- SPARK::CreateSPARKObject(counts = counts, location = coords)
    spark@lib_size <- apply(spark@counts, 2, sum)

    spark <- SPARK::spark.vc(
            spark, covariates = NULL, lib_size = spark@lib_size, verbose = FALSE, num_core = 4)
    sink("/dev/null")
    spark <- SPARK::spark.test(spark, check_positive = TRUE, verbose = FALSE)
    sink()

    write_results(spark@res_mtest, pckg_name="spark", analysis="svgenes", extra_name="_spark")
}

args <- commandArgs(trailingOnly = TRUE)
base_file <- args[1]

spe <- load_SpE(base_file)
spark_workflow(spe)
