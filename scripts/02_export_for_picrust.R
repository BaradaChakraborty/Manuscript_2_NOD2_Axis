# Script 02: Exporting Taxonomic Data for PICRUSt2 Prediction
# Author: Barada Chakraborty

load("E:/Anaerobutyricum_Gut_Project/karlsson_data_ready.RData")

library(phyloseq)

# 1. Extract the raw abundance matrix from the phyloseq object
otu_table_export <- as(otu_table(ps_karlsson), "matrix")

# PICRUSt2 requires features (bacteria) to be rows and samples to be columns.
# We check the orientation and transpose if necessary.
if (taxa_are_rows(ps_karlsson) == FALSE) {
  otu_table_export <- t(otu_table_export)
}

# 2. Convert to a dataframe and explicitly create an 'OTU_ID' column
otu_df <- as.data.frame(otu_table_export)
otu_df$OTU_ID <- rownames(otu_df)

# Reorder columns to ensure 'OTU_ID' is the very first column (Strict PICRUSt2 requirement)
otu_df <- otu_df[, c("OTU_ID", setdiff(colnames(otu_df), "OTU_ID"))]

# 3. Export as a tab-separated values (.tsv) text file into our new data folder
write.table(otu_df, 
            file = "data/raw/karlsson_otu_table_for_picrust.tsv",
            sep = "\t", 
            row.names = FALSE, 
            quote = FALSE)

cat("Phase 1 Complete. Abundance matrix successfully exported for PICRUSt2.\n")