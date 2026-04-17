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

# 2. Query and download the actual Karlsson 2013 functional gene matrix from the cloud
# (This fetches the TreeSummarizedExperiment object containing the exact patient data)
karlsson_dataset <- curatedMetagenomicData("KarlssonFH_2013.gene_families", dryrun = FALSE)

# 3. Extract the biological object from the downloaded list
karlsson_se <- karlsson_dataset[[1]]

# 4. Strip out the raw matrix and uncompress it (convert from dgCMatrix to standard matrix)
real_func_matrix <- as.matrix(assay(karlsson_se))

# 5. Save the true data directly to your project's raw folder
write.csv(real_func_matrix, 
          file = "data/raw/karlsson_kegg_orthologs.csv", 
          row.names = TRUE)

cat("Success! The REAL Karlsson functional matrix has been uncompressed and saved.\n")