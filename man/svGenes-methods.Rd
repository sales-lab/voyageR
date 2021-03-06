% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sv.R
\docType{methods}
\name{svGenes}
\alias{svGenes}
\alias{svGenes,SpatialExperiment-method}
\alias{svGenes,SpatialExperiment,ANY-method}
\title{Identifies spatially variable genes.}
\usage{
svGenes(x, method, verbose = FALSE, ...)

\S4method{svGenes}{SpatialExperiment}(x, method = c("spatialde", "spark"), verbose = FALSE, assay = "counts")
}
\arguments{
\item{x}{\link{SpatialExperiment} object.}

\item{method}{Name of the method for testing spatial variability.}

\item{verbose}{Set to \code{TRUE} to enable verbose mode.}

\item{...}{Additional arguments.}

\item{assay}{Extract gene expression from the assay with the given name
(by default, "counts").}
}
\value{
A copy of the input \link{SpatialExperiment} object, extended with
a new \code{rowData} column named after the method used for the analysis
(for instance, "spatialde"). The new column holds a \code{data.frame} with
the full output of the analysis.
}
\description{
You can select one among the following statistical tests:
\itemize{
\item spatialde, from \href{https://www.nature.com/articles/nmeth.4636}{Svensson et al, 2018}.
\item spark, from \href{https://www.nature.com/articles/s41592-019-0701-7}{Sun et al, 2020}.
}
}
\examples{
svGenes(mockSVGenes(100, 2, 100), method = "spatialde")

}
