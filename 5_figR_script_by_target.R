R.version
#install.packages("BiocManager")

library("BiocManager")


print("load dplyr")
install.packages("dplyr")
library("dplyr")
print("loaded dplyr")


devtools::install_github("caleblareau/BuenColors")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")

BiocManager::install(c("ComplexHeatmap", "chromVAR", "GenomicRanges", "SummarizedExperiment", "motifmatchr"))

library("BSgenome.Hsapiens.UCSC.hg38")

print("done with dependencies!!!")
install.packages("devtools")
devtools::install_github("buenrostrolab/FigR")
print("installed figr")

library("FigR")
print("loaded figr")



# External arguments
args <- commandArgs(trailingOnly = TRUE)
SE_path <- args[1]
seurat_object_path <- args[2]
features_of_interest = args[3]
i = args[4]
padding = args[5]
output_filename <- "correlations.csv"

# to produce the file in SE_path, run the following in a notebook prior to running this script:
# colDATA<-JAN_028_combined_filtered@meta.data[c("nCount_ATAC","nFeature_ATAC","target")]
# rowRanges <- granges(JAN_028_combined_filtered[['ATAC']])
#SummarizedExperiment(assays=list(counts=JAN_028_combined_filtered@assays$ATAC@counts), rowRanges=rowRanges, colData=colDATA)
load(SE_path)
JAN_028_combined=readRDS(seurat_object_path)
features_of_interest=read.table(features_of_interest)
fragments_of_interest=features_of_interest$x
print("loaded all data")

SE_GRCh38_JAN_028_filtered=SE_GRCh38_JAN_028[fragments_of_interest,]
JAN_028_RNA_filtered=JAN_028_combined
perturbed_tfs=unique(SE_GRCh38_JAN_028@colData$perturbation_name)

main.chroms <- c('chr1','chr2','chr3','chr4','chr5','chr6','chr7','chr8','chr9','chr10','chr11','chr12','chr13','chr14','chr15','chr16','chr17','chr18','chr19','chr20','chr21','chr22','chrX','chrY','chrM')
keep.peaks <- which(as.character(seqnames(granges(SE_GRCh38_JAN_028_filtered))) %in% main.chroms)
SE_GRCh38_JAN_028_filtered=SE_GRCh38_JAN_028_filtered[keep.peaks,]

coi=row.names(as.data.frame(SE_GRCh38_JAN_028@colData) %>%
filter(target == i))

print("processed all data")

# Run using multiple cores if parallel support
cisCor <- runGenePeakcorr(ATAC.se = SE_GRCh38_JAN_028_filtered[,coi], #NEEDS TO BE RAW
                           RNAmat = JAN_028_RNA_filtered[,which(colnames(JAN_028_RNA_filtered) %in% coi)], #NEEDS TO BE NORAMLIZED
                           genome = "hg38", # Also supports mm10 and hg38
                           nCores = 80, 
                          keepPosCorOnly = FALSE,
                          keepMultiMappingPeaks=TRUE,
                          windowPadSize = as.vector(as.numeric(padding)),
                           p.cut=NULL)
write.table(cisCor, output_filename)