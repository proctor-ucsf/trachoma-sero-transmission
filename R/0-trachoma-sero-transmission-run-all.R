#-----------------------------------
# This script runs all computational
# notebooks used in the article:
#
# Tedijanto et al. 
# Monitoring transmission intensity 
# of trachoma with serology: a multi-country study
#
# There are 8 scripts, run sequentially
# and sequentially numbered in the repository
#-----------------------------------

library(here)
here::here()

#-----------------------------------
# create analysis datasets
# download larger file of publicly 
# available data and process it
# for analysis, saving analysis datasets
#-----------------------------------
rmarkdown::render(here::here("R/1-make-datasets.Rmd"),
                  output_file = here::here("R/1-make-datasets.html"))


#-----------------------------------
# Estimate seroconversion rates
# (force of infection / FOI) using
# different modeling strategies
# and store estimates at the cluster-
# and study level.
#-----------------------------------
rmarkdown::render(here::here("R/2-estimate-foi.Rmd"),
                  output_file = here::here("R/2-estimate-foi.html"))

#-----------------------------------
# Summarize study means
# Figure 1
#-----------------------------------
rmarkdown::render(here::here("R/3-plot-study-means.Rmd"),
                  output_file = here::here("R/3-plot-study-means.html"))

#-----------------------------------
# Estimate age-seroprevalence
# curves. Create a summary figure
# Figure 2
#-----------------------------------
rmarkdown::render(here::here("R/4-age-sero-curves.Rmd"),
                  output_file = here::here("R/4-age-sero-curves.html"))

#-----------------------------------
# Assess the relationship between
# different serological summary
# measures (mean IgG, seroprev, seroconversion rates)
# Figure 3. Supporting Figs 3, 8 
#-----------------------------------
rmarkdown::render(here::here("R/5-compare-sero-summaries.Rmd"),
                  output_file = here::here("R/5-compare-sero-summaries.html"))

#-----------------------------------
# Compare seroprevalence and SCR
# with infection by PCR
# also compare TF with PCR infection
# Figures 4, 5. Supporting Figs 3, 4
#-----------------------------------
rmarkdown::render(here::here("R/6-compare-sero-pcr.Rmd"),
                  output_file = here::here("R/6-compare-sero-pcr.html"))

#-----------------------------------
# Classify clusters as infection-free
# by different seroprevalence
# and different SCR cutoffs
# Figure 6. Supporting Figs 5, 6
#-----------------------------------
rmarkdown::render(here::here("R/7-sero-thresholds.Rmd"),
                  output_file = here::here("R/7-sero-thresholds.html"))

#-----------------------------------
# Sensitivity analysis of the influence
# of seropositivity cutoff on 
# cluster classification above/below
# thresholds identified in the previous
# analysis
# Supporting Fig 7
#-----------------------------------
rmarkdown::render(here::here("R/8-compare-cutoffs.Rmd"),
                  output_file = here::here("R/8-compare-cutoffs.html"))

