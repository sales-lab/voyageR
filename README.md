# spatial-benchmark
Benchmark for spatial expression

<br />

# Indice
- [Package to include](#package-to-include)
- [Useful links](#useful-links)
- [Categories and packages ](#useful-links)
    - [Cell type deconvolution ](#cell-type-deconvolution)
    - [Spatially Variable Genes](#spatially-variable-genes)
    - [Spatial Region](#spatial-region)
    - [Gene Patterns](#gene-patterns)
    - [Cell-cell interactions](#cell-cell-interactions)
- [Datasets](#datasets)
- [Benchmarking Metrics](#benchmarking-metrics)

<br /><br />

## Package to include
Add here paper/package to include in the respective tables
| Package | link | category | note |
| ----- | ----------- | ----------- | ----------- |

<br /><br />

## Useful links
| Link | Note |
| ----- | ----------- |
| [SpatialDB: a database for spatially resolved transcriptomes](http://www.spatialomics.org/SpatialDB/index.php) | Ci sono diversi dati di trascrittomica spaziale. Il più recente è del 2019. Non c'è il visium |
| [Awesome-Spatial-Omics: repository for collecting single-cell spatial omics resources](https://github.com/drighelli/awesome-spatial-omics) | |
| [10x Visium Datasets](https://support.10xgenomics.com/spatial-gene-expression/datasets) |
| [t-CyCIF Datasets](https://www.cycif.org/data/)  |
| [Giotto Datasets](https://github.com/RubD/spatial-datasets) |
| [Spatial Transcriptomics Datasets](https://www.spatialresearch.org/resources-published-datasets/) |
| [Paper: Integrating microarray-based spatial transcriptomics and single-cell RNA-seq reveals tissue architecture in pancreatic ductal adenocarcinomas](https://www.nature.com/articles/s41587-019-0392-8) | Fanno un elenco dei tessuti e dei dataset prodotti attraverso la tecnologia ST |
| [Paper](https://www.nature.com/articles/s41593-020-00787-0) |   Annotazione manuale su dati 10x Visium |
 
<br /><br />

## Categories and packages
### Cell type deconvolution
[Torna all'indice](#indice) 
| Package | Language | Paper | Repo |
| ----------- | ----------- | ----------- | ----------- |
| NMFreg      | Python; Matlab  | [paper](https://science.sciencemag.org/content/363/6434/1463) | https://github.com/tudaga/NMFreg_tutorial |
| Seurat3      | R | [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6687398/) | https://satijalab.org/seurat/ |
| RCTD      | R       | [paper](https://www.nature.com/articles/s41587-021-00830-w) | https://github.com/dmcable/RCTD |
| Tangram      | Python       | [paper](https://www.biorxiv.org/content/10.1101/2020.08.29.272831v3) | https://github.com/broadinstitute/Tangram |
| stereoscope      | Python | [paper](https://www.nature.com/articles/s42003-020-01247-y) | https://github.com/almaan/stereoscope |
| DSTG      | Python | [paper](https://academic.oup.com/bib/advance-article/doi/10.1093/bib/bbaa414/6105942) | https://github.com/Su-informatics-lab/DSTG |
| SPOTlight      | R | [paper](https://academic.oup.com/nar/advance-article/doi/10.1093/nar/gkab043/6129341) | Repo: https://github.com/MarcElosua/SPOTlight Analisi: https://github.com/MarcElosua/SPOTlight_deconvolution_analysis |
| Giotto      | R       | [paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02286-2) | https://rubd.github.io/Giotto_site/ |
| CellDART | Python | [paper](https://www.biorxiv.org/content/10.1101/2021.04.26.441459v1.full) | https://github.com/mexchy1000/CellDART |
| Spacell | Python | [paper](https://academic.oup.com/bioinformatics/article/36/7/2293/5663455) | https://github.com/BiomedicalMachineLearning/Spacell |  | 
| SpiceMix | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.11.29.383067v2.full) | https://github.com/ma-compbio/SpiceMix | 
| SpatialDWLS | R | [paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02362-7) | https://github.com/rdong08/spatialDWLS_dataset |
| Squidpy | Python | [paper](https://www.biorxiv.org/content/10.1101/2021.02.19.431994v2.full) | Repo: https://github.com/theislab/squidpy Doc: https://squidpy.readthedocs.io/en/latest/ |
| STdeconvolve | R | [paper](https://www.biorxiv.org/content/10.1101/2021.06.15.448381v1) | https://github.com/JEFworks-Lab/STdeconvolve |


<br /><br />

### Spatially Variable Genes
[Torna all'indice](#indice) 
| Package | Language | Paper | Repo | 
| ----------- | ----------- | ----------- | ----------- |
| trendsceek | R | [paper](https://www.nature.com/articles/nmeth.4634) | https://github.com/edsgard/trendsceek |
| SpatialDE | Python | [paper](https://www.nature.com/articles/nmeth.4636) | https://github.com/Teichlab/SpatialDE |
| scGCO | Python | [paper](https://www.biorxiv.org/content/10.1101/491472v2) | https://github.com/WangPeng-Lab/scGCO |
| Seurat3 | R | [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6687398/) | https://satijalab.org/seurat/ | 
| RayleighSelection | R; C++ | [paper](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1007509) | https://github.com/CamaraLab/RayleighSelection |
| SPARK | R; C++ | [paper](https://www.nature.com/articles/s41592-019-0701-7) | https://github.com/xzhoulab/SPARK |
| GPcounts | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.07.29.227207v3) | https://github.com/ManchesterBioinference/GPcounts |
| GLISS | NA | [paper](https://www.biorxiv.org/content/10.1101/2020.08.12.248971v1.full) | https://github.com/junjiezhujason/gliss | 
| singleCellHaystack | R | [paper](https://www.nature.com/articles/s41467-020-17900-3) | Github: https://github.com/alexisvdb/singleCellHaystack CRAN: https://cran.r-project.org/web/packages/singleCellHaystack/index.html |
| SPATA | R | [paper](https://www.biorxiv.org/content/10.1101/2020.10.20.346544v1) | Repo: https://github.com/theMILOlab/SPATA Sito: https://themilolab.github.io/SPATA/ |
| Giotto | R | [paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02286-2) | Repo: https://github.com/RubD/Giotto DevelVersion: https://rubd.github.io/Giotto_site/ Sito: http://spatialgiotto.rc.fas.harvard.edu/ |
| SOMDE | Python | [paper](http://dx.doi.org/10.1093/bioinformatics/btab471) | https://github.com/WhirlFirst/somde |
| Splotch | Python (e R) | [paper](https://www.biorxiv.org/content/10.1101/757096v1.full) | https://github.com/tare/Splotch |
| SpaGCN | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.11.30.405118v1.full) | https://github.com/jianhuupenn/SpaGCN |
| BOOST-GP | C++; R | Published [paper](https://academic.oup.com/bioinformatics/advance-article-abstract/doi/10.1093/bioinformatics/btab455/6306406?redirectedFrom=fulltext) Preprint [from arXiv](https://arxiv.org/abs/2012.03326) | https://github.com/Minzhe/BOOST-GP |
| Gene-Spatial | Python | [paper](https://www.nature.com/articles/s41598-019-41951-2) | https://github.com/RuishanLiu/Gene-Spatial | 
| STUtility | R | [paper](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-020-06832-3) | Repo: https://github.com/jbergenstrahle/STUtility Doc: https://ludvigla.github.io/STUtility_web_site/index.html | 
| JSTA | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.09.18.304147v1.full) | https://github.com/wollmanlab/JSTA |
| Spark-X | R | [paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02404-0) | https://github.com/xzhoulab/SPARK |
| MERINGUE | R | [paper](https://genome.cshlp.org/content/early/2021/05/25/gr.271288.120.abstract) | https://github.com/JEFworks-Lab/MERINGUE |

 
<br /><br />

### Spatial Region
[Torna all'indice](#indice) 
| Package | Language | Paper | Repo | Note |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| smfishHmrf | python; C++ | [paper](https://www.nature.com/articles/nbt.4260) | https://bitbucket.org/qzhudfci/smfishhmrf-py/src/master/ | is written in Python 3. It uses R/C++ to run the core HMRF inference. Infatti è disponibile anche in R https://bitbucket.org/qzhudfci/smfishhmrf-r/src/master/ . smfishHmrf-py is the package we recommend for running HMRF analysis. |
| SSAM | Python; C++ | [paper](https://www.biorxiv.org/content/10.1101/800748v2) | https://github.com/HiDiHlabs/ssam | Currently SSAM was only tested with Python 3 in Linux environment. In addition to this package, SSAM requires a local R installation with pre-installed packages feather and sctransform. |
| stLearn | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.05.31.125658v1) | Repo: https://github.com/BiomedicalMachineLearning/stLearn/ Docs: https://stlearn.readthedocs.io/en/latest/ | E' un lavorone. Fanno tante cose |
| BayesSpace | R; C++ | [paper](https://www.biorxiv.org/content/10.1101/2020.09.04.283812v1.full) | https://github.com/edward130603/BayesSpace | Sottomesso a `BioConductor` |
| Baysor | Julia | [paper](https://www.biorxiv.org/content/10.1101/2020.10.05.326777v1) | https://github.com/kharchenkolab/Baysor | Ti fanno creare un eseguibile |
| SpaGCN | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.11.30.405118v1.full) | https://github.com/jianhuupenn/SpaGCN | SpaGCN is applicable to both in-situ transcriptomics with single-cell resolution (seqFISH, seqFISH+, MERFISH, STARmap, and FISSEQ) and spatial barcoding based transcriptomics (Spatial Transcriptomics , SLIDE-seq, SLIDE-seqV2, HDST, 10x Visium, DBiT-seq, Stero-seq, and PIXEL-seq) data. |
| MULTILAYER | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.11.09.374660v1.full) | https://github.com/SysFate/MULTILAYER | Da verificare se è la categoria giusta. E' un eseguibile, forse non adatto per un benchmark | 
| Spage2vec | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.02.12.945345v1.full) | https://github.com/wahlby-lab/spage2vec | Anche SVGenes o Gene Patterns probabilmente |

<br /><br />

### Gene Patterns
[Torna all'indice](#indice) 
| Package | Language | Paper | Repo | Note |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| SpatialDE | Python | [paper](https://www.nature.com/articles/nmeth.4636) | https://github.com/Teichlab/SpatialDE | è integrato anche dentro Giotto |
| std-nb | C++ | [paper](https://www.biorxiv.org/content/10.1101/362624v2) | https://github.com/SpatialTranscriptomicsResearch/std-nb |  |
| stLearn | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.05.31.125658v1) | Repo: https://github.com/BiomedicalMachineLearning/stLearn/ Docs: https://stlearn.readthedocs.io/en/latest/ | E' un lavorone. Fanno tante cose |
| GLISS | NA | [paper](https://www.biorxiv.org/content/10.1101/2020.08.12.248971v1.full) | | in BiorXiv; Dicono che è powerful almeno quanto SpatialDE e più powerful di scGCO |
| sepal | Python | [paper](https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/btab164/6168120) | https://github.com/almaan/sepal | Forse anche SVgenes o Spatial Region. Si analizza da riga di comando |
| MERINGUE | R | [paper](https://genome.cshlp.org/content/early/2021/05/25/gr.271288.120.abstract) | https://github.com/JEFworks-Lab/MERINGUE | |


<br /><br />

### Cell-cell interactions
[Torna all'indice](#indice) 
| Package | Language | Paper | Repo | Note | Version | Last Update | Working? | User friendlyness |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |----------- |
| SVCA | R; Python; C; C++; Fortran | [paper](https://www.sciencedirect.com/science/article/pii/S2211124719311325) | https://github.com/damienArnol/svca | |
| SpaOTsc | Python | [paper](https://www.nature.com/articles/s41467-020-15968-5) | https://github.com/zcang/SpaOTsc | Pubblicato su Nature Communication. Da leggere|
| MISTy | R | [paper](https://www.biorxiv.org/content/10.1101/2020.05.08.084145v1) | Repo: https://github.com/saezlab/mistyR/ Sito: https://saezlab.github.io/misty/ | 
| stLearn | Python | [paper](https://www.biorxiv.org/content/10.1101/2020.05.31.125658v1) | Repo: https://github.com/BiomedicalMachineLearning/stLearn/ Docs: https://stlearn.readthedocs.io/en/latest/ | E' un lavorone. Fanno tante cose |
| DIALOGUE | R | [paper](https://www.biorxiv.org/content/10.1101/2020.08.11.245472v1) | https://github.com/livnatje/DIALOGUE |  |
| GCNG | Python | [paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-020-02214-w) | https://github.com/xiaoyeye/GCNG | Si esegue da linea di comando |
| Giotto | R | [paper](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-021-02286-2) | Repo: https://github.com/RubD/Giotto DevelVersion: https://rubd.github.io/Giotto_site/ Sito: http://spatialgiotto.rc.fas.harvard.edu/ | |
| MERINGUE | R | [paper](https://genome.cshlp.org/content/early/2021/05/25/gr.271288.120.abstract) | https://github.com/JEFworks-Lab/MERINGUE | |

<br /><br />

## Datasets
[Torna all'indice](#indice) 
| Name/Tissue | Version | Technology | Paper | Download link | Used by | Ground Truth (if present) | Accessibility |Notes|
| ----------- | ----------- | ----------- | ----------- |----------- | ----------- | ----------- | ----------- | ----------- | 
|human postmortem DLPFC tissue sections from two pairs of ‘spatial replicates’ from three independent neurotypical adult donors||10x Visium|[spatialLIBD](https://www.biorxiv.org/content/10.1101/2021.04.29.440149v1.full) [data paper](https://www.nature.com/articles/s41593-020-00787-0#Sec1)|[SpatialLIBD](https://bioconductor.org/packages/release/data/experiment/html/spatialLIBD.html)|||[Tutorial](http://spatial.libd.org/spatialLIBD/)| The package provides also some datasets in SpE format |
| Mouse somatosensory cortex | | seqFISH+ | [paper](https://www.nature.com/articles/s41586-019-1049-y) | [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2019_seqfish_plus_SScortex) | Giotto | 
| Mouse olfactory bulb | | seqFISH+ | [paper](https://www.nature.com/articles/s41586-019-1049-y) | [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2019_seqfish_plus_olfactory_bulb) |
| Mouse brain cerebellum | | Slide-Seq | [paper](https://science.sciencemag.org/content/363/6434/1463) | [original link](https://singlecell.broadinstitute.org/single_cell/study/SCP354/slide-seq-study) [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2019_slideseq_cerebellum) |
| Mouse brain cortex | | StarMAP 3D | [paper](https://science.sciencemag.org/content/361/6400/eaat5691) | [original link](https://www.starmapresources.com/data) [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2018_starmap_3D_cortex)  |
| Mouse somatosensory cortex | | osmFISH | [paper](https://www.nature.com/articles/s41592-018-0175-z) | [original link](https://linnarssonlab.org/osmFISH/) [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2018_osmFISH_SScortex) |
| Mouse preoptic hypothalamus | | merFISH 3D | [paper](https://science.sciencemag.org/content/362/6416/eaau5324) | [original link](https://datadryad.org/stash/dataset/doi:10.5061/dryad.8t8s248) [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2018_merFISH_science_hypo_preoptic)  |
| Mouse spleen | | CODEX | [paper](https://www.sciencedirect.com/science/article/pii/S0092867418309048) | [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2018_codex_spleen) | 
| Human pancreatic ductal adenocarcinoma (PDAC)| | tissue-based cyclic immunofluorescence (t-CyCIF) | [paper](https://elifesciences.org/articles/31657) | [original link](https://www.cycif.org/data/) [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2018_CyCIF_PDAC) | | | | Ci sono diversi dataset qui |
| triple negative breast cancer (TNBC) patients | | MIBI | [paper](https://www.cell.com/fulltext/S0092-8674(18)31100-0) | [original link](https://www.angelolab.com/mibi-data) [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2019_slideseq_cerebellum) | 
| Mouse olfactory bulb | | Spatial Transcriptomics | [paper](https://science.sciencemag.org/content/353/6294/78) | [original link](https://www.spatialresearch.org/resources-published-datasets/) [directory](https://github.com/RubD/spatial-datasets/blob/master/data/2016_ST_olfactory_bulb) |
| Human breast cancer | | Spatial Transcriptomics | [paper](https://science.sciencemag.org/content/353/6294/78) | [original link](https://www.spatialresearch.org/resources-published-datasets/) | 
| Mouse hippocampus | | seqFISH | [paper](https://www.sciencedirect.com/science/article/pii/S0896627316307024?via%3Dihub) | [Download from supplementary material](https://www.sciencedirect.com/science/article/pii/S0896627316307024#app2) | SpatialDE | | | Credo che quello che usano in SpatialDE sia la "Table S6. Raw Expression Data for 249 Genes"  |
| Human osteosarcoma cell line |  | MERFISH | [paper](https://doi.org/10.1073%2Fpnas.1612826113) | From the [Zhuang lab website](http://zhuang.harvard.edu/merfish) they downloaded this file [MERFISH .zip](http://zhuang.harvard.edu/MERFISHData/data_for_release.zip) | SpatialDE | 
| Xenopus embryos | | Frog Development RNA-seq data | [paper](https://doi.org/10.1016%2Fj.celrep.2015.12.050) | [Download GSE65785](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE65785) | SpatialDE | |  | Applicano SpatialDE anche a  |
| Mouse gastrulation epiblast cells from mice at age embryonic day 6.5 | | scRNA-seq | [paper](https://doi.org/10.1038%2Fnature18633) | [Download link](http://gastrulation.stemcells.cam.ac.uk/data/counts.gz) | trendsceek | | |  we investigated whether trendsceek could find spatial patterns in two-dimensional representations of dissociated single-cell data (t-SNE). |
| Human developmental heart |  | ST | [paper](https://www.sciencedirect.com/science/article/pii/S0092867419312826) | [Download](https://www.spatialresearch.org/resources-published-datasets/doi-10-1016-j-cell-2019-11-025/) | SpatialDWLS (sia per ST che scRNA-seq)|  | | Da qui si può scaricare sia ST che scRNA-seq| 
| Adult Mouse Brain Section (Visium and scRNA-seq) | v1.1.0 | 10x Visium e scRNA-seq | [paper  scRNA-seq](https://science.sciencemag.org/content/347/6226/1138)  | [Download Spatial 10x Visium](https://www.10xgenomics.com/resources/datasets?menu%5Bproducts.name%5D=Spatial%20Gene%20Expression&query=&page=1&configure%5Bfacets%5D%5B0%5D=chemistryVersionAndThroughput&configure%5Bfacets%5D%5B1%5D=pipeline.version&configure%5BhitsPerPage%5D=500) - [Download scRNA-seq](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE60361)  | SpatialDWLS (sia per Spatial che scRNA-seq) | | | [Annotated data here for the scRNA-seq](http://linnarssonlab.org/cortex/) |
| MOp: Primary motor area of health adult mouse brainc | v3 | 10Xv3 scRNA-seq and Slide-seq2 (Spatial; Adult mouse brain) | [paper](https://www.nature.com/articles/s41587-020-0465-8) | [Download scRNA-seq](https://storage.googleapis.com/tommaso-brain-data/tangram_demo/mop_sn_tutorial.h5ad.gz) - [Download Slide-seq2 (Spatial)](https://storage.googleapis.com/tommaso-brain-data/tangram_demo/slideseq_MOp_1217.h5ad.gz) - [Download markers genes](https://storage.googleapis.com/tommaso-brain-data/tangram_demo/MOp_markers.csv) | Tangram | | | Marker genes obtained from [here](https://www.biorxiv.org/content/10.1101/2020.06.04.105700v1); All datasets need to be unzipped: resulting h5ad and csv files should be placed in the data folder. Link obtained from their [tutorial](https://github.com/broadinstitute/Tangram/blob/master/example/1_tutorial_tangram.ipynb)|
| Mouse lumbar spinal cord (presymptomatic) | | ST | [paper](https://science.sciencemag.org/content/364/6435/89) | [Avalaible here](https://als-st.nygenome.org/) |
| Postmortem lumbar spinal cord SLA | | ST | [paper](https://science.sciencemag.org/content/364/6435/89) | [Avalaible here](https://als-st.nygenome.org/)  
| Postmortem cervical spinal cord SLA | | ST | [paper](https://science.sciencemag.org/content/364/6435/89) |  [Avalaible here](https://als-st.nygenome.org/) |
| Human Melanoma lymph node biopsies |  | ST | [paper](https://cancerres.aacrjournals.org/content/78/20/5970) | [Spatial Research Download](https://www.spatialresearch.org/resources-published-datasets/doi-10-1158-0008-5472-can-18-0747/) |
| Human Prostate Cancer | | ST | [paper](https://www.nature.com/articles/s41467-018-04724-5) | [Spatial Research Download](https://www.spatialresearch.org/resources-published-datasets/10-1038-s41467-018-04724-5/) |
| Human periodontal tissue | | ST | [paper](https://www.nature.com/articles/s41598-018-27627-3) | 
| Adult human health tissue | | ST | [paper](https://www.nature.com/articles/s41598-017-13462-5) | [Spatial Research Download](https://www.spatialresearch.org/resources-published-datasets/doi10-1038s41598-017-13462-5/)
| Model Plant Species | | ST | [paper](https://www.nature.com/articles/nplants201761) | [Spatial Research Download](https://www.spatialresearch.org/resources-published-datasets/10-1038-nplants-2017-61/)


<br /><br />

## Benchmarking Metrics 
[Torna all'indice](#indice) 
| Package | Language | Category | Analysis | Metric | 
| ----------- | ----------- | ----------- | ----------- | ----------- |
