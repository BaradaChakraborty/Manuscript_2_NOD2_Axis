# Manuscript 2: The NOD2/TLR4 Axis in Type 2 Diabetes

**Author:** Barada Chakraborty
**Domain:** Computational Immunology, Host-Microbe Interactions, and Metagenomics
**Status:** Complete / Pipeline Finalized

## Project Overview
This repository contains a complete, end-to-end computational pipeline analyzing high-resolution shotgun metagenomic data from the Karlsson et al. (2013) clinical cohort. The core objective of this research is to investigate the "microbial trigger" hypothesis of metabolic inflammation, specifically comparing the genetic capacity of the microbiome to synthesize peptidoglycan (NOD2 axis) and lipopolysaccharide (TLR4 axis) across different metabolic phenotypes: Normal Glucose Tolerance (NGT/Control), Impaired Glucose Tolerance (IGT), and Type 2 Diabetes (T2D).

This methodology transitions away from predictive functional profiling (e.g., PICRUSt2) and instead utilizes directly measured MetaCyc pathway abundance data extracted via the HUMAnN pipeline, processed in R.

## Pipeline Architecture
The analysis is structured into a reproducible, sequential R-script pipeline:

* **`01_...` / `02_fetch_karlsson_shotgun_data.R`**: Interrogates the `curatedMetagenomicData` repository to extract 145 clinical shotgun samples, prioritizing full MetaCyc pathway abundance matrices over raw gene families.
* **`03_NOD2_Functional_Analysis.R`**: Extracts the absolute genetic capacity for Peptidoglycan Biosynthesis (PWY-6471), the primary ligand for the host NOD2 receptor.
* **`03b_TLR4_Functional_Analysis.R`**: Isolates Lipopolysaccharide (LPS) and Lipid A Biosynthesis pathways to map the TLR4 inflammatory axis.
* **`04_NOD2_Phenotype_Plot.R` & `04b_TLR4_Phenotype_Plot.R`**: Merges biological loads with clinical metadata. Applies robust non-parametric statistical testing (Kruskal-Wallis global tests and FDR-corrected Wilcoxon pairwise rank-sum tests) via `ggpubr`.
* **`05a_LPS_Strain_Switching.R`**: Deconvolutes the total LPS pool into species-specific contributions, explicitly testing the ratio of toxic (Proteobacteria) vs. inhibitory (Bacteroidetes) LPS sources.
* **`05b_Butyrate_Barrier.R`**: Scans the metagenome for Short-Chain Fatty Acid (Butyrate) biosynthesis pathways to evaluate gut barrier/mucus shield integrity.
* **`06_Butyrate_Phenotype_Plot.R`**: Statistically evaluates the Butyrate load to test the "Leaky Gut" hypothesis.

## Key Scientific Findings

1.  **Stable NOD2 Capacity (The Null Hypothesis Verified):**
    Microbial genetic capacity to synthesize the NOD2 trigger (peptidoglycan) remains statistically stable across all metabolic phenotypes (Kruskal-Wallis, p = 0.14). This suggests NOD2 signaling dysregulation in T2D is driven by host-side receptor exhaustion, not microbial overabundance.
2.  **The Transitional LPS Spike (TLR4 Axis):**
    Total LPS biosynthesis capacity is highly dynamic (p = 0.0052), but strictly non-linear. The microbial TLR4 trigger spikes significantly during the pre-diabetic (IGT) transition phase but returns to baseline levels in established T2D.
3.  **Strain Conservation:**
    The transitional LPS spike is not driven by a structural replacement of "safe" Bacteroidetes LPS with "toxic" Proteobacteria LPS. In this cohort, strain-switching does not explain the inflammatory phenotype.
4.  **Stable Gut Barrier Shield:**
    The genetic capacity for Butyrate biosynthesis (the host's primary mucus shield maintainer) does not collapse as the disease progresses (p = 0.23), directly challenging the classical linear "Leaky Gut" barrier failure model.

## Core Conclusion: The Host Autonomy Model
By systematically ruling out progressive NOD2 trigger accumulation, LPS strain-switching, and Butyrate-driven barrier failure, this data strongly supports a **Host Autonomy / Hit-and-Run Model**. The microbiome provides a transitional inflammatory "spark" (the IGT-phase LPS spike) that permanently polarizes host macrophages. By the time established T2D is reached, the host's immune system remains in a hyper-sensitive feedback loop, sustaining severe metabolic inflammation even after the microbiome has settled back into a baseline, compensated state.

## Technologies Used
* **R & RStudio**
* **Bioconductor:** `curatedMetagenomicData`, `phyloseq`
* **Tidyverse:** `dplyr`, `ggplot2`
* **Statistics:** `ggpubr` (Non-parametric ranking, FDR adjustments)

## View High-Resolution Figures and Manuscript Draft Here
https://drive.google.com/drive/folders/1OexvOf-b1ZXMOtWg5Ha25--78vf3ibr3?usp=sharing
