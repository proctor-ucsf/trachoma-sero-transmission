# trachoma-sero-transmission

Monitoring transmission intensity of trachoma with serology


## Description

This repository includes R code to run all of the analysis for the paper:

_Monitoring transmission intensity of trachoma with serology: a multi-country study_

Tedijanto et al. (in review)

Should you have any questions about the files in this repository, please contact Ben Arnold at UCSF (ben.arnold@ucsf.edu).

## Linked Repositories and Additional Resources

### Open Science Framework
This GitHub repository is mirrored on the Open Science Framework (OSF).  The OSF project page includes additional study-related resources, including the compiled HTML computational notebooks created from the `.Rmd` files:

https://osf.io/e6j5a/

### Dryad 

The data will be archived on Dryad (pending)

## _Nature_ Research Code Submission Items

Following: https://www.nature.com/documents/nr-software-policy.pdf

### System Requirements

All analyses were run using R software version 4.2.2 on Mac OSX Big Sur using the RStudio IDE (https://www.rstudio.com).

`> sessionInfo()`

` R version 4.2.2 (2022-10-31)`

` Platform: x86_64-apple-darwin17.0 (64-bit)`

` Running under: macOS Big Sur ... 10.16`

### Installation Guide

You can download and install R from CRAN: https://cran.r-project.org

You can download and install RStudio from their website: https://www.rstudio.com

All R packages required to run the analyses are sourced in the file `0-Config.R`.

The installation time should be < 10 minutes total on a typical desktop computer.

### Instructions for Use

To reproduce all analyses in the paper, we recommend that you: 

1. clone the GitHub repository

2. Create a `data` subdirectory and copy the two datasets from OSF or Dryad (**public data pending**)

3. Create an `output` subdirectory to store output. 

4. All of the analysis scripts should run smoothly (scripts `1-xx` to `8-xx`). 

The first data processing script will create the final analysis datasets. You will need to modify the `final_data_path <-` statement in `0-Config.R` to point to the location of the data on your local computer.

You can run the `.Rmd` notebook scripts one-by-one or you can compile `0-trachoma-sero-transmission-run-all.R`, which is the file we used to run the final analyses (e.g., from the command line `R CMD BATCH 0-trachoma-sero-transmission-run-all.R &`).

Running the all analyses on the above Mac desktop configuration required 23 minutes. 

Note that the only script that takes very long is `2-estimate-foi.Rmd` because estimating the hundreds of reversible catalytic models is computationally slow. 

### License

This project is covered by the CC0 1.0 Universal license.
