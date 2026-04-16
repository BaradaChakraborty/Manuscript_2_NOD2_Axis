# Setup script for NOD2/Peptidoglycan exhaustion hypothesis
# Author: Barada Chakraborty

# 1. Load core libraries
# using suppressPackageStartupMessages to keep the console clean
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(stringr)
})

# 2. Build local directory structure
# recursively checking if folders exist before creating them
dirs_to_make <- c("data/raw", "data/processed", "figures", "results")

for (d in dirs_to_make) {
  if (!dir.exists(d)) {
    dir.create(d, recursive = TRUE)
    cat("Created directory:", d, "\n")
  } else {
    cat("Directory already exists:", d, "\n")
  }
}

# 3. Define our functional targets (The Peptidoglycan synthesis pathway)
# These KOs are required to build the MDP motif that triggers host NOD2
nod2_trigger_kos <- c(
  "K00725", # murA
  "K01924", # murC 
  "K01925", # murD
  "K01928", # murE
  "K01929"  # murF
)

# save the target list so we can call it in subsequent filtering scripts
saveRDS(nod2_trigger_kos, file = "data/processed/nod2_target_kos.rds")
cat("Initialization complete. Targets locked.\n")