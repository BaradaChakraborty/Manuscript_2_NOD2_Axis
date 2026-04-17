# Script: Fetching the REAL Karlsson 2013 Functional Dataset
# Author: Barada Chakraborty

# 1. Install the required Bioconductor data-fetching packages
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install(c("curatedMetagenomicData", "SummarizedExperiment"))

library(curatedMetagenomicData)
library(SummarizedExperiment)

cat("Connecting to global repository to fetch Karlsson 2013 data...\n")

# 2. Query and download the Pathway Abundance matrix
karlsson_dataset <- curatedMetagenomicData("KarlssonFH_2013.pathway_abundance", dryrun = FALSE)

# 3. Extract the biological object
karlsson_se <- karlsson_dataset[[1]]

# 4. Uncompress into a standard matrix
real_pathway_matrix <- as.matrix(assay(karlsson_se))

# 5. Save the true pathway data
write.csv(real_pathway_matrix, 
          file = "data/raw/karlsson_pathways.csv", 
          row.names = TRUE)

cat("Success! The REAL Karlsson functional matrix has been uncompressed and saved.\n")