suppressMessages(library(TENxVisiumData))
suppressMessages(library(SpatialExperiment))
suppressMessages(library(SummarizedExperiment))
suppressMessages(library(spatialLIBD))
suppressMessages(library(zellkonverter))
suppressMessages(library(dbplyr))


detach_SpE <- function(spe) {
    coords <- as.data.frame(SpatialExperiment::spatialCoords(spe))
    counts <- as.matrix(SummarizedExperiment::assay(spe, "counts"))

    tokens <- list(counts=counts, coords=coords)
    return(tokens)
}


load_SpE <- function(base_file){
    spe <- readRDS(paste0(base_file, ".rds"))
    return(spe)
}


write_results <- function(df, pckg_name, analysis, extra_name = ""){
    path_results <- paste0("/results/", analysis, "/", pckg_name)
    write.table(df, file = paste0(path_results, "/", "results", extra_name, ".csv"), quote = FALSE, sep="\t", 
            row.names = T, col.name = NA)
    saveRDS(df, file = paste0(path_results, "/", "results", extra_name, ".rds"))
}


get_SpE_object <- function(dataset, libd_sample, shuffle){
    switch(dataset,
       spatialLIBD={
           spe <- spatialLIBD::fetch_data(type="spe")
           libd_sample <- as.character(libd_sample)
           stopifnot(libd_sample %in% c("151507", "151508", "151509", "151510", "151669", "151670", "151671", "151672", "151673", "151674", "151675", "151676"))
           ## randomly taking one out of 12 samples 
           # SAMPLE Available: 151507, 151508, 151509, 151510, 151669, 151670, 151671, 151672, 151673, 151674, 151675, 151676, 
           spe <- spe[, spe$sample_id == libd_sample]
       },
       {
           ##all other cases are TENxVisium dataset ids
           stopifnot(libd_sample == "null")
           # query for TENxVisium datasets
           eh <- suppressMessages(ExperimentHub())
           (q <- query(eh, "TENxVisium"))
           # retrieve dataset of interest
           pat <- dataset
           idx <- grep(pat, q$title)
           id <- q$ah_id[idx][1]
           spe <- suppressMessages(eh[[id]])
       })
    
    stopifnot(shuffle %in% c("yes", "no"))
    if( shuffle == "yes" ) {
        rownames(spatialCoords(spe)) <- rownames(spatialCoords(spe))[sample(1:nrow(spatialCoords(spe))) ]
        spatialCoords(spe) <- spatialCoords(spe)[match(colnames(spe), rownames(spatialCoords(spe))),]
    }
    
    return(spe)
}


spe_to_files <- function(dataset, libd_sample, shuffle, filename){
    spe <- get_SpE_object(dataset, libd_sample, shuffle)
    
    saveRDS(spe, file = paste0(filename, ".rds"))

    stopifnot(all(rownames(colData(spe)) == rownames(spatialCoords(spe))))
    colData(spe) <- cbind(colData(spe), spatialCoords(spe))
    colData(spe)$scaleFactor <- imgData(spe)$scaleFactor
    zellkonverter::writeH5AD(spe, paste0(filename, ".h5ad"))
}
