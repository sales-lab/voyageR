suppressMessages(library(TENxVisiumData))
suppressMessages(library(SpatialExperiment))
suppressMessages(library(SummarizedExperiment))
suppressMessages(library(spatialLIBD))

detach_SpE <- function(spe) {
    coords <- as.data.frame(SpatialExperiment::spatialCoords(spe))
    counts <- as.matrix(SummarizedExperiment::assay(spe, "counts"))

    tokens <- list(counts=counts, coords=coords)
    return(tokens)
}


load_SpE <- function(dataset){
    switch(dataset,
       spatialLIBD={
           spe <- spatialLIBD::fetch_data(type="spe")
           ## randomly taking one out of 12 samples 
           spe <- spe[, spe$sample_id == "151508"]
       },
       {##all other cases are TENxVisium dataset ids
           # query for TENxVisium datasets
           eh <- suppressMessages(ExperimentHub())
           (q <- query(eh, "TENxVisium"))
           # retrieve dataset of interest
           pat <- dataset
           idx <- grep(pat, q$title)
           id <- q$ah_id[idx][2]
           spe <- suppressMessages(eh[[id]])
       })

    return(spe)
}


write_results <- function(df, extra_name = ""){
    write.table(df, file = paste("results", extra_name, ".csv", sep=""), quote = FALSE, sep="\t", 
            row.names = T, col.name = NA)
}


spe_to_h5ad <- function(dataset, filename){
    spe <- load_SpE(dataset)
    stopifnot(all(rownames(colData(spe)) == rownames(spatialCoords(spe))))
    colData(spe) <- cbind(colData(spe), spatialCoords(spe))
    colData(spe)$scaleFactor <- imgData(spe)$scaleFactor
    zellkonverter::writeH5AD(spe, filename)
}
