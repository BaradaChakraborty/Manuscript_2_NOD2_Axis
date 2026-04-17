# Script 06: Visualizing Gut Barrier (Butyrate) Capacity Across Phenotypes
# Author: Barada Chakraborty

library(dplyr)
library(ggplot2)
library(phyloseq)
library(ggpubr)

# 1. Extract the clinical metadata
clinical_meta <- as(sample_data(ps_karlsson), "data.frame")
clinical_meta$Sample_ID <- rownames(clinical_meta)

# 2. Merge the biological Butyrate loads with the clinical diagnoses
final_butyrate_data <- merge(patient_butyrate_load, clinical_meta, by = "Sample_ID")

# 3. Define the specific pairwise comparisons we want to test
my_comparisons <- list( c("control", "IGT"), c("IGT", "T2D"), c("control", "T2D") )

# 4. Generate the Plot with Integrated Statistics
butyrate_plot <- ggplot(final_butyrate_data, aes(x = study_condition, y = Butyrate_Load, fill = study_condition)) +
  geom_boxplot(outlier.shape = 21, outlier.size = 2, alpha = 0.8) +
  theme_minimal(base_size = 14) +
  scale_fill_manual(values = c("control" = "#999999", "IGT" = "#E69F00", "T2D" = "#D55E00")) +
  labs(
    title = "Microbial Butyrate Biosynthesis Capacity (Gut Barrier Shield)",
    subtitle = "Testing the Gut Barrier Failure (Leaky Gut) Hypothesis",
    x = "Clinical Phenotype",
    y = "Total Butyrate Pathway Abundance",
    fill = "Cohort"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, face = "italic"),
    legend.position = "none"
  ) +
  # --- THE STATISTICS LAYERS ---
  stat_compare_means(method = "kruskal.test", label.y = max(final_butyrate_data$Butyrate_Load) * 1.1) +
  stat_compare_means(comparisons = my_comparisons,
                     method = "wilcox.test",
                     p.adjust.method = "fdr",
                     label = "p.signif")

# Display the plot
print(butyrate_plot)

# Save the plot
ggsave("results/Butyrate_Shield_Karlsson_Stats.png", plot = butyrate_plot, width = 8, height = 6, dpi = 300)
cat("Butyrate Shield Plot with integrated statistics successfully generated!\n")