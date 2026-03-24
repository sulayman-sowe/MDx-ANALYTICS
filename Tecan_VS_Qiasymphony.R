# Working Directory

getwd()
setwd("C:/Users/sulsowe/Documents/WORKINGS/PLOTS/QIAsymphony_vs_tecan_comparision/ANALYSIS_TWO_02_06_26")

# Load the relevant packages
library(tidyverse)
library(readxl)
library(ggplot2)

# Load nanodrop data
df_nanodrop <- read_excel("C:/Users/sulsowe/Documents/WORKINGS/Tecan_vs_Qiasymphony_SP_Repeat.xlsx", sheet = "Nanodrop values")

# Paired plot
ggplot(df_nanodrop, aes(x = Platform, y = Concentration, group = Sample_ID)) +
  geom_point(size = 2, alpha = 0.7) +
  geom_line(alpha = 0.7) +
  stat_summary(fun = mean, geom = "point", size = 4, color = "red") +
  theme_minimal() +
  labs(title = "Nanodrop DNA Yield: Tecan vs QIAsymphony",
       subtitle = "6 out of 7 samples showed reduced yield with Tecan extraction",
       y = "DNA concentration (ng/µL)")
 
ggsave("nanodrop_plot.png", width = 7, height = 5, dpi = 300)



# qPCR Data

# Load data
df_ct_raw <- read_excel("C:/Users/sulsowe/Documents/WORKINGS/Tecan_Vs_Qiasymphony_Results_01_06_26.xlsx", sheet = "ct_values", col_names = FALSE)

# Extract both platforms
# Tecan
df_tecan <- df_ct_raw[, 1:3] %>%
  rename(Sample_ID = ...1, Fluor = ...2, Ct = ...3) %>%
  mutate(Platform = "Tecan")

# QIAsymphony
df_qia <- df_ct_raw[, 8:10] %>%
  rename(Sample_ID = ...8, Fluor = ...9, Ct = ...10) %>%
  mutate(Platform = "QIAsymphony")

# Combine and clean
df_ct <- bind_rows(df_tecan, df_qia) %>%
  filter(!is.na(Sample_ID), !is.na(Fluor), !is.na(Ct)) %>%
  filter(Sample_ID != "Sample") %>%  # remove header row
  mutate(
    Sample_ID = as.numeric(Sample_ID),
    Ct = as.numeric(Ct)
  )


# Faceted paired plot
ggplot(df_ct, aes(x = Platform, y = Ct, group = Sample_ID)) +
  geom_point(alpha = 0.6) +
  geom_line(alpha = 0.5) +
  facet_wrap(~ Fluor) +
  theme_minimal() +
  stat_summary(fun = mean, geom = "point", size = 3, color = "red") +
  geom_hline(yintercept = 37, linetype = "dashed", color = "darkgreen") +
  scale_y_reverse()+
  labs(title = "qPCR Ct Comparison by Fluorophore")

ggsave("qPCR_plot2.png", width = 7, height = 5, dpi = 300)


# Alternative

library(readxl)
library(dplyr)
library(ggplot2)

# Load data
df_ct_raw <- read_excel("C:/Users/sulsowe/Documents/WORKINGS/Tecan_Vs_Qiasymphony_Results_01_06_26.xlsx", sheet = "ct_values", col_names = FALSE)

# Extract both platforms
# Tecan
df_tecan <- df_ct_raw[, 1:3] %>%
  rename(Sample_ID = ...1, Fluor = ...2, Ct = ...3) %>%
  mutate(Platform = "Tecan")

# QIAsymphony
df_qia <- df_ct_raw[, 8:10] %>%
  rename(Sample_ID = ...8, Fluor = ...9, Ct = ...10) %>%
  mutate(Platform = "QIAsymphony")

# Combine and clean
df_ct <- bind_rows(df_tecan, df_qia) %>%
  filter(!is.na(Sample_ID), !is.na(Fluor), !is.na(Ct)) %>%
  filter(Sample_ID != "Sample") %>%  # remove header row
  mutate(
    Sample_ID = as.numeric(Sample_ID),
    Ct = as.numeric(Ct)
  )

# Ensure Sample_ID is treated as a distinct category (factor) before plotting
df_ct <- df_ct %>% 
  mutate(Sample_ID = factor(Sample_ID))

# Faceted paired plot 
ggplot(df_ct, aes(x = Platform, y = Ct, group = Sample_ID, color = Sample_ID)) +
  # Draw colored lines and points first
  geom_line(linewidth = 1, alpha = 0.8) +
  geom_point(size = 2.5, alpha = 0.9) +
  
  # Separate into columns by fluorophore
  facet_wrap(~ Fluor) +
  
  # Use a built-in high-contrast color palette (Qualitative "Set1")
  scale_color_brewer(palette = "Set1") +
  
  # Add the green threshold line
  geom_hline(yintercept = 37, linetype = "dashed", color = "darkgreen", linewidth = 0.8) +
  
  # Add the black diamond mean summary on top
  # (color = "black" inside aes() forces it to ignore the sample colors)
  stat_summary(aes(group = 1), fun = mean, geom = "point", size = 4, color = "black", shape = 18) +
  
  # Invert Y-axis
  scale_y_reverse(breaks = seq(15, 45, by = 5)) +
  
  # Apply clean theme and labels
  theme_bw() +
  labs(
    title = "qPCR Ct Comparison by Fluorophore",
    subtitle = "Dashed line indicates diagnostic Cutoff (Ct = 37). Black diamonds represent channel means.",
    x = "Extraction Platform",
    y = "qPCR Cycle Threshold (Ct)",
    color = "Sample ID"
  ) +
  theme(
    panel.grid.minor = element_blank(),
    strip.text = element_text(face = "bold", size = 11),
    legend.position = "right"
  )

# Save the plot
ggsave("qPCR_plot_colored.png", width = 8, height = 5, dpi = 300)








