# Script 05b: Testing Gut Barrier Collapse via Butyrate Depletion
# Author: Barada Chakraborty

library(dplyr)

# 1. Link to the main functional matrix in RAM
functional_matrix <- real_pathway_matrix

# 2. Hunt down Butyrate/Butanoate synthesis pathways
# We want the un-stratified totals (NO "|" in the name)
all_butyrate_rows <- grep("butyrate|butanoate", rownames(functional_matrix), ignore.case = TRUE, value = TRUE)
total_butyrate_rows <- all_butyrate_rows[!grepl("\\|", all_butyrate_rows)]

cat("Found the following Butyrate pathways:\n", paste(total_butyrate_rows, collapse="\n "), "\n")

# 3. Extract the Butyrate subset
butyrate_matrix <- functional_matrix[total_butyrate_rows, , drop = FALSE]

# 4. Calculate the Butyrate load (The "Shield" metric)
patient_butyrate_load <- data.frame(
  Sample_ID = colnames(butyrate_matrix),
  Butyrate_Load = colSums(butyrate_matrix)
)

cat("\nPhase 5b Complete: Total Butyrate Shield capacity calculated.\n")