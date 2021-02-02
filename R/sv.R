#' Identifies spatially variable genes.
#'
#' You can select one among the following statistical tests:
#' * spatialde, from [Svensson et al, 2018](https://www.nature.com/articles/nmeth.4636).
#' * spark, from [Sun et al, 2020](https://www.nature.com/articles/s41592-019-0701-7).
#'
#' @param x Spatial gene expression object.
#' @param method Name of the method for testing spatial variabily.
#' @param ... Additional arguments.
#'
#' @importFrom methods setGeneric
#' @export
#' @docType methods
#' @rdname svGenes-methods
setGeneric("svGenes", function(x, method, ...) standardGeneric("svGenes"))

#' Identifies spatially variable gene from the given SpatialExperiment.
#'
#' @param x [SpatialExperiment] object.
#' @param method Name of the method for testing spatial variability.
#' @param assay Extract gene expression from the assay with the given name
#'  (by default, "counts").
#'
#' @return A copy of the input [SpatialExperiment] object, extended with
#'  a new `rowData` column named after the method used for the analysis
#'  (for instance, "spatialde"). The new column holds a `data.frame` with
#'  the full output of the analysis.
#'
#' @importFrom methods setMethod
#' @importFrom SummarizedExperiment assay rowData
#' @importFrom SpatialExperiment spatialCoords
#' @export
#'
#' @rdname svGenes-methods
#' @aliases svGenes,SpatialExperiment,ANY-method
#' 
#' @examples 
#' svGenes(mockSVGenes(20, 2, 20), method = "spatialde")
#' 
setMethod("svGenes",
          "SpatialExperiment",
          function(x,
                   method = c("spatialde", "spark"),
                   assay = "counts") {
            method <- match.arg(method)
            counts <- SummarizedExperiment::assay(x, assay)
            switch(method,
                   spatialde = spatialde_svg(x, counts),
                   spark = spark_svg(x, counts))
          })

spatialde_svg <- function(x, counts) {
  pacman::p_load_gh("sales-lab/spatialDE@wrap_functions")
  
  coordinates <- as.data.frame(spatialCoords(x))
  
  sample_info <- coordinates
  sample_info$total_counts <- colSums(counts)
  
  stabilized <- spatialDE::stabilize(counts)
  regressed <- spatialDE::regress_out(sample_info, stabilized)
  output <- spatialDE::run(coordinates, regressed)
  
  ordering <- match(rownames(counts), output$g)
  SummarizedExperiment::rowData(x)$spatialde <- output[ordering, ]
  return(x)
}

spark_svg <- function(x, counts) {
  pacman::p_load_gh("sales-lab/SPARK")
  
  cn <- colnames(counts)
  coordinates <- as.data.frame(spatialCoords(x))
  rownames(coordinates) <- cn
  
  # Creating SPARK Object
  spark <- SPARK::CreateSPARKObject(counts = counts, location = coordinates, 
                                    percentage = 0.1, min_total_counts = 10)
  spark@lib_size <- apply(spark@counts, 2, sum)
  
  # TODO: get in input `num_core`
  spark <- SPARK::spark.vc(spark, covariates = NULL, lib_size = spark@lib_size, 
                           num_core = 1, verbose = T, fit.maxiter = 500)
  spark <- SPARK::spark.test(spark, check_positive = T, verbose = T)
  
  output <- spark@res_mtest
  
  ordering <- match(rownames(counts), rownames(output))
  SummarizedExperiment::rowData(x)$spark <- output[ordering, ]
  return(x)
}
