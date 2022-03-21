suppressMessages(library(TENxVisiumData))
suppressMessages(library(SpatialExperiment))
suppressMessages(library(SummarizedExperiment))
suppressMessages(library(spatialLIBD))
suppressMessages(library(zellkonverter))
suppressMessages(library(dbplyr))
suppressMessages(library(scater))


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


### Scripts for datasets

get_SpE_object <- function(dataset, libd_sample, shuffle, remove_mito=TRUE){
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

    spe <- filter_spe(spe=spe)
    
    stopifnot(shuffle %in% c("yes", "no"))
    if( shuffle == "yes" ) {
        rownames(spatialCoords(spe)) <- rownames(spatialCoords(spe))[sample(1:nrow(spatialCoords(spe))) ]
        spatialCoords(spe) <- spatialCoords(spe)[match(colnames(spe), rownames(spatialCoords(spe))),]
    }
    
    return(spe)
}

# https://github.com/lmweber/nnSVG/blob/2ec35c88abfd30942fae6b3fb6761f78e7a48d9a/R/filter_genes.R#L67
filter_spe <- function(spe, filter_genes_ncounts = 3, filter_genes_pcspots = 0.5, filter_mito = TRUE) {
    if (!is.null(filter_genes_ncounts) & !is.null(filter_genes_pcspots)) {
        nspots_perc <- ceiling(filter_genes_pcspots / 100 * ncol(spe))
        non_detected_genes <- rowSums(counts(spe) >= filter_genes_ncounts) < nspots_perc
        
        spe <- spe[!non_detected_genes, ]
    }
    
    if(filter_mito) {
        # Filtering mitochondrial genes
        mtc <- grepl("^MT-", rowData(spe)$gene_name, ignore.case = T)
        spe <- spe[!mtc,]
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
