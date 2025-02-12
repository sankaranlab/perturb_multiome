R.version
#install.packages("BiocManager")
print("install summarized experiment")
install.packages("SummarizedExperiment")
print("done installing summarized experiment")
library("BiocManager")
install.packages("Seurat")
install.packages("PMA")
install.packages("protoclust")
BiocManager::install("glmGamPoi")
remotes::install_version("SeuratObject", "4.1.4", repos = c("https://satijalab.r-universe.dev", getOption("repos")))
remotes::install_version("Seurat", "4.4.0", repos = c("https://satijalab.r-universe.dev", getOption("repos")))
print("done with dependencies!!!")

print("install Signac")
setRepositories(ind=1:3)
install.packages("Signac")
print("done with Signac")

install.packages("devtools")
# Note: if running on ATAC, install modified branch here as explained in the notebook FINAL_GITHUB_TF_sensitive_element_computation
#modified repo would be installed here for ATAC
#detach("package:Mixscale", unload=TRUE)
#devtools::install_github("",auth_token = '')

devtools::install_github("longmanz/Mixscale")
print("installed mixscale")

library("Mixscale")
print("loaded Mixscale")
library(Seurat)
print("loaded Seurat")

# External arguments
args <- commandArgs(trailingOnly = TRUE)
seurat_object_path <- args[1]
TF = args[2]
print(TF)

seurat_obj_mixscale_separate_guides_AAVS1_1_reference=readRDS(seurat_object_path)


print("starting last step")
library("Mixscale")
# modify here to nCount_ATAC in modified repo
de_res_seurat_obj_mixscale_separate_guides_AAVS1_1_reference = Run_wmvRegDE(object = seurat_obj_mixscale_separate_guides_AAVS1_1_reference, assay = "RNA", slot = "counts",
                      labels = "gene", nt.class.name = "negative_control", 
                      PRTB_list = TF,
                      logfc.threshold = 0,
                      total_ct_labels = 'nCount_RNA', 
                      min.pct=0)

saveRDS(de_res_seurat_obj_mixscale_separate_guides_AAVS1_1_reference,"mixscale_results.RDS")