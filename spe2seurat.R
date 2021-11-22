library(Seurat)
library(SpatialExperiment)


spe2seurat <- function(dataset = "MouseBrainCoronal"){
    spe <- load_SpE(dataset = dataset)

    coords <- cbind.data.frame(spatialData(spe), spatialCoords(spe))
    colnames(coords) <- c("tissue", "row", "col", "imagerow", "imagecol")

    imgR <- imgRaster(spe)
    imgObj <- new(
        Class= 'VisiumV1',
        image=as(imgR, "array"),
        scale.factors=scalefactors(
            spot = imgData(spe)$scaleFactor,
            fiducial = 0.0, ## put here fiducial if present
            hires = 0.0, imgData(spe)$scaleFactor ## put here high and low res scale factors
        ), 
        coordinates = coords, ## coordinates in data.frame format
        spot.radius = 0
        ## substitute spot.radius (to compute as unnormalized.radius <- scale.factors$fiducial_diameter_fullres * scale.factors$tissue_lowres_scalef
        ## spot.radius <-  unnormalized.radius / max(dim(x = image)))
    )
    
    se1 <- CreateSeuratObject(counts=counts(spe), assay="Spatial")

    imgObj <- imgObj[Cells(x = se1)]
    DefaultAssay(object = imgObj) <- "Spatial"
    se1[["slice1"]] <- imgObj

    se1
}
