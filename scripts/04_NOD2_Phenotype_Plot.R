# Script 04: Visualizing NOD2 Triggers Across Metabolic Phenotypes
# Author: Barada Chakraborty

library(dplyr)
library(ggplot2)
library(phyloseq)
library(ggpubr) # The new stats library

# 1. Extract the clinical metadata
clinical_meta <- as(sample_data(ps_karlsson), "data.frame")
clinical_meta$Sample_ID <- rownames(clinical_meta)

# 2. Merge the biological loads with the clinical diagnoses
final_nod2_data <- merge(patient_pg_load, clinical_meta, by = "Sample_ID")

# 3. Define the specific pairwise comparisons we want to test
my_comparisons <- list( c("control", "IGT"), c("IGT", "T2D"), c("control", "T2D") )

# 4. Generate the Plot with Integrated Statistics
nod2_plot <- ggplot(final_nod2_data, aes(x = study_condition, y = PG_Load, fill = study_condition)) +
  geom_boxplot(outlier.shape = 21, outlier.size = 2, alpha = 0.8) +
  theme_minimal(base_size = 14) +
  # Using the colors from your successful plot
  scale_fill_manual(values = c("control" = "#999999", "IGT" = "#E69F00", "T2D" = "#D55E00")) + 
  labs(
    title = "Microbial Peptidoglycan (murA-F) Load Across Metabolic Phenotypes",
    subtitle = "Testing the pre-diabetic NOD2 exhaustion hypothesis",
    x = "Clinical Phenotype",
    y = "Total Peptidoglycan Synthesis Gene Abundance",
    fill = "Cohort"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, face = "italic"),
    legend.position = "none"
  ) +
  # --- THE STATISTICS LAYERS ---
  # Layer A: Global Kruskal-Wallis p-value printed at the top
  stat_compare_means(method = "kruskal.test", label.y = max(final_nod2_data$PG_Load) * 1.1) +
  # Layer B: Pairwise Wilcoxon tests with FDR correction drawn as brackets
  stat_compare_means(comparisons = my_comparisons,
                     method = "wilcox.test",
                     p.adjust.method = "fdr",
                     label = "p.signif") # Displays standard significance stars (*, **, ***) or 'ns'

# Display the plot
print(nod2_plot)

# Save the plot
ggsave("results/NOD2_Peptidoglycan_Load_Karlsson_Stats.png", plot = nod2_plot, width = 8, height = 6, dpi = 300)
cat("Plot with integrated statistics successfully generated!\n")