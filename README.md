### MDx-ANALYTICS

A robust R-based analytics suite designed for processing, interpreting, and performing quality control (QC) on molecular diagnostics (MDx) assay outputs. 

### 🔬 Scientific Context

In molecular diagnostics, data uniformity and reproducibility are critical. This repository houses specialized workflows meant to analyze and model laboratory assay data. It automates the parsing of quantitative metrics (such as cycle threshold values, amplification slopes, and fluorescence signals) to expedite pathogen detection and assay validation workflows. 

### 📊 Features

* **Automated Data Wrangling:** Eliminates manual spreadsheet processing of instrumentation logs.
* **Rigorous QC Filtering:** Automatically flags low-quality amplification curves or failed internal controls based on statistical thresholds.
* **Exploratory Visualizations:** Built-in scripts to track assay run variance and batch effects across longitudinal diagnostic studies.

### 🛠️ Tech Stack & Dependencies

* **Language:** R
* **Libraries:** tidyverse, ggplot2 (for publication-grade diagnostic plots), broom (for statistical modeling tidy-ups)

### 🚀 Getting Started

### Execution

Open your R environment or RStudio project, source the pipeline functions, and feed your quantitative dataset: 

R

source("src/mdx_processing_functions.R")

# Run diagnostic cleaning pipeline
cleaned_data <- process_mdx_run(input_file = "data/raw_assay_log.txt")

Use code with caution.

Contact: ssulayman636@gmail.com
