# Script 03: Extracting Peptidoglycan Biosynthesis Pathways
# Author: Barada Chakraborty

library(dplyr)

# 1. Link directly to the newly downloaded pathway matrix in RAM
functional_matrix <- real_pathway_matrix

# 2. Hunt down the Peptidoglycan Biosynthesis pathways (ignoring upper/lower case)
target_pathways <- grep("peptidoglycan|PWY-6471", rownames(functional_matrix), ignore.case = TRUE, value = TRUE)
cat("Found the following Peptidoglycan pathways:\n", paste(target_pathways, collapse="\n "), "\n")

# 3. Extract those specific pathway rows
mur_pathway_data <- functional_matrix[target_pathways, , drop = FALSE]

# 4. Aggregate the total "Peptidoglycan Synthesis Load" per patient
patient_pg_load <- data.frame(
  Sample_ID = colnames(mur_pathway_data),
  PG_Load = colSums(mur_pathway_data)
)

cat("Phase 3 Complete: True Peptidoglycan Pathway loads calculated.\n")