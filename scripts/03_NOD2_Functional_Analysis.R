# Script 03: Extracting Measured NOD2 Triggers (murA-F)
# Author: Barada Chakraborty

library(dplyr)
library(tidyr)

# 1. Load the biological targets we locked in Step 1
nod2_targets <- readRDS("data/processed/nod2_target_kos.rds")
cat("Loaded target KOs:", paste(nod2_targets, collapse=", "), "\n")

# 2. Link directly to the matrix already in our RAM from Script 02
functional_matrix <- real_func_matrix

# 3. Extract ONLY the peptidoglycan synthesis genes (murA-F)
mur_operon_data <- functional_matrix[rownames(functional_matrix) %in% nod2_targets, ]

# 4. Aggregate the total "Peptidoglycan Synthesis Load" per patient
patient_pg_load <- data.frame(
  Sample_ID = colnames(mur_operon_data),
  PG_Load = colSums(mur_operon_data)
)

cat("Phase 3 Complete: Peptidoglycan loads calculated for all patients.\n")