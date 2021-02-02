test_that("spatialDE identifies variable genes", {
  set.seed(42)
  
  se <- mockSVGenes(20, 2, 20)
  output <- svGenes(se, method = "spatialde")
  
  expect_s4_class(output, "SpatialExperiment")
  
  rd <- rowData(output)
  expect_named(rd, c("gene", "spatialde"), ignore.order = TRUE)
  
  sde <- rd$spatialde
  expect_s3_class(sde, "data.frame")
  expect_true(all(c("g", "qval") %in% colnames(sde)))
  expect_identical(sde$g, rd$gene)
  
  expect_true(all(sde[1:2, "qval"] < 0.05))
  expect_true(all(sde[3:20, "qval"] > 0.05))
})


test_that("SPARK identifies variable genes", {
  set.seed(42)
  
  se <- mockSVGenes(20, 2, 20)
  counts <- counts <- SummarizedExperiment::assay(se, "counts")
  output <- svGenes(se, method = "spark")
  
  expect_s4_class(output, "SpatialExperiment")
  
  rd <- rowData(output)
  expect_named(rd, c("gene", "spark"), ignore.order = TRUE)
  
  sparkde <- rd$spark
  expect_s3_class(sparkde, "data.frame")
  expect_true(all(c("combined_pvalue", 
                    "adjusted_pvalue") %in% colnames(sparkde)))
  expect_true(all(rownames(sparkde) %in% rownames(counts)))
  
  svgenes <- c("gene1", "gene2", "gene4", "gene7", "gene16", "gene20")
  no_svgenes <- c("gene3", "gene5", "gene6", "gene8", "gene9", "gene10", 
                  "gene11", "gene12", "gene13", "gene14", "gene15",  "gene17", 
                  "gene18", "gene19")
  
  expect_true(all(sparkde[svgenes, "adjusted_pvalue"] < 0.05))
  expect_true(all(sparkde[no_svgenes, "adjusted_pvalue"] > 0.05))
})
