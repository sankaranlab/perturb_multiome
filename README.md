# Code to analyze Perturb-multiome experiments
This repository contains custom code to analyze Perturb-multiome experiments. Below, you can find the title of the corresponding notebook or script in this GitHub repository next to a brief explanation of its purpose.<br /><br />

1. GITHUB_processing_RNA_object: first notebook to process the output from Cellranger.<br /><br />
2. GITHUB_processing_perturb_multiome_object: second notebook to prepare the single cell object. The final single cell object is obtained in 3a<br /><br />
3. TF_sensitive_element_computation<br />
-3a. GITHUB_TF_sensitive_element_computation: contains code to obtain the final single cell object and perform the first step of TF-sensitive element computation<br /><br />
-3b. mixscale_script_only_final_step_for_Terra_WDL.R. This can be run using [terra.bio](https://terra.bio/) using the WDL script from step 3c<br /><br />
-3c. WDL: WDL code to run the prior script, 3b, as a workflow in [terra.bio](https://terra.bio/). You need to update /path/to/mixscale_script_only_final_step_for_Terra_WDL.R to the bucket path where you place that script<br /><br />
4. GITHUB_RNA_ATAC_WNN_UMAPs: contains code to generate WNN UMAPs<br /><br />
5. figR_script_by_target.R: script to compute correlations<br /><br />
6. GITHUB_RNA_ATAC_correlations: imports correlations from figR for downstream analyses<br /><br />
7. GITHUB_generating_QC_plots: to generate QC metric plots<br /><br />
8. LDSC folder, contains the following files:<br />
-8a. GITHUB_LD_regression_first_step <br />
-8b. GITHUB_LD_regression_second_step <br />
-8c. WDL_LDSC: the WDL used to run the final step of LDSC regression on genomic features of choice, as referenced in 8a or 8b. <br /><br />
9. GITHUB_Scavenge: contains code to run Scavenge analyses. <br />

If any plot fails to render in Github, please download the file and load locally.