# Script 03b: Extracting Lipopolysaccharide (LPS) Biosynthesis Pathways
# Author: Barada Chakraborty

library(dplyr)

# 1. Link directly to the pathway matrix already in RAM
functional_matrix <- real_pathway_matrix

# 2. Hunt down LPS and Lipid A Biosynthesis pathways
# (Lipid A is the toxic, immune-activating core of LPS)
lps_pathways <- grep("lipopolysaccharide|lipid A", rownames(functional_matrix), ignore.case = TRUE, value = TRUE)
cat("Found the following LPS pathways:\n", paste(lps_pathways, collapse="\n "), "\n")

# 3. Extract those specific LPS pathway rows
lps_pathway_data <- functional_matrix[lps_pathways, , drop = FALSE]

# 4. Aggregate the total "LPS Synthesis Load" per patient
# We will save this as a DIFFERENT variable so we don't overwrite your NOD2 data
patient_lps_load <- data.frame(
  Sample_ID = colnames(lps_pathway_data),
  LPS_Load = colSums(lps_pathway_data)
)

cat("Phase 3b Complete: True LPS Pathway loads calculated.\n")