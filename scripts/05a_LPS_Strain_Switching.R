# Script 05a: Resolving the LPS Paradox via Strain-Switching
# Author: Barada Chakraborty

library(dplyr)

# 1. Link to the main functional matrix in RAM
functional_matrix <- real_pathway_matrix

# 2. Find ALL LPS pathways, then isolate ONLY the rows that name specific species (they contain a "|")
all_lps_rows <- grep("lipopolysaccharide|lipid A", rownames(functional_matrix), ignore.case = TRUE, value = TRUE)
species_lps_rows <- all_lps_rows[grepl("\\|", all_lps_rows)]

# 3. Categorize the LPS by source (Toxic vs. Inhibitory)
toxic_bugs <- grep("Escherichia|Klebsiella|Enterobacter|Shigella", species_lps_rows, ignore.case = TRUE, value = TRUE)
inhibitory_bugs <- grep("Bacteroides|Prevotella|Alistipes", species_lps_rows, ignore.case = TRUE, value = TRUE)

# 4. Extract the subsets
toxic_matrix <- functional_matrix[toxic_bugs, , drop = FALSE]
inhibitory_matrix <- functional_matrix[inhibitory_bugs, , drop = FALSE]

# 5. Calculate the loads
patient_lps_sources <- data.frame(
  Sample_ID = colnames(functional_matrix),
  Toxic_LPS = colSums(toxic_matrix),
  Inhibitory_LPS = colSums(inhibitory_matrix)
)

cat("Phase 5a Complete: Separated Toxic (Proteobacteria) vs. Inhibitory (Bacteroidetes) LPS.\n")
cat("Toxic strains found:", length(toxic_bugs), "\n")
cat("Inhibitory strains found:", length(inhibitory_bugs), "\n")