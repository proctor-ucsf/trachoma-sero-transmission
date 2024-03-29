# trachoma-sero-transmission

Monitoring transmission intensity of trachoma with serology


## Description

This repository includes R code to run all of the analysis for the paper:

Tedijanto, C., Solomon, A.W., Martin, D.L. et al. **Monitoring transmission intensity of trachoma with serology**. _Nature Communications_ **14**, 3269 (2023). https://doi.org/10.1038/s41467-023-38940-5

This work was funded by the National Institute of Allery and Infectious Diseases (R01-AI158884).

Should you have any questions about the files in this repository, please contact Ben Arnold at UCSF (ben.arnold@ucsf.edu), the PI for the study.


## Linked Repositories and Additional Resources

### Open Science Framework
This GitHub repository is mirrored on the Open Science Framework (OSF).  The OSF project page includes additional study-related resources, including the compiled HTML computational notebooks created from the `.Rmd` files, and the final analysis datasets that are created by `1-make-datasets.Rmd`.

https://osf.io/e6j5a/

This study draws from Version 2 of a larger public dataset that has been harmonized and made publicly available under the NIH-funded study: _Seroepidemiology of trachoma for the elimination endgame_ [R01-AI158884](https://reporter.nih.gov/search/Vp1i0zHsQkOOzfYshpRgOQ/project-details/10181859).

https://osf.io/ykjc4/

### Dryad 

The harmonized data will eventually be archived on Dryad (pending)

## _Nature_ Research Code Submission Items

Following: https://www.nature.com/documents/nr-software-policy.pdf

### System Requirements

All analyses were run using R software version 4.2.2 on Mac OSX Big Sur using the RStudio IDE (https://www.rstudio.com).

`> sessionInfo()`

` R version 4.2.2 (2022-10-31)`

` Platform: x86_64-apple-darwin17.0 (64-bit)`

` Running under: macOS Big Sur ... 10.16`

In this repository we have created a Docker container and have used the `renv` package to archive the package versions so that you and reproduce the exact compute environment on an instance of R Studio Server, should you wish to do so. 

### Installation Guide and Instructions for Use (Desktop)

You can download and install R from CRAN: https://cran.r-project.org

You can download and install RStudio from their website: https://www.rstudio.com

All R packages required to run the analyses are sourced in the file `0-Config.R`.

The installation time should be < 10 minutes total on a typical desktop computer.

To reproduce all analyses in the paper, we recommend that you: 

1. Clone the GitHub repository to your computer

For example, in the location on your computer where you would like to clone the repository, you could type into the Terminal command:

`git clone https://github.com/proctor-ucsf/trachoma-sero-transmission.git`

2. Recreate the exact package environment using the `renv` package. 

You can do this by opening the R project file ([trachoma-sero-transmission.Rproj](https://github.com/proctor-ucsf/trachoma-sero-transmission/blob/main/trachoma-sero-transmission.Rproj)) in RStudio, loading the `renv` package, and typing `renv::restore()` to restore the package environment from the projects [renv.lock](https://github.com/proctor-ucsf/trachoma-sero-transmission/blob/main/renv.lock) file. 

3. All of the analysis scripts should run smoothly (scripts `1-xx.Rmd` to `8-xx.Rmd`). 

### Installation Guide and Instructions for Use (Docker / RStudio Server)

The repository includes a `Dockerfile` and archive of package versions in the `renv.lock` file that you can use to build a Docker image and then launch a container on RStudio Server. 

You can download and install Docker from: https://docs.docker.com/get-docker/

For MacOS users, we also recommend installing Homebrew to ensure git and docker work smoothly: https://docs.brew.sh/Installation

After installing Docker and (optionally) homebrew, follow these steps:

1. Clone the GitHub repository to your computer, from the Terminal command line:

`git clone https://github.com/proctor-ucsf/trachoma-sero-transmission.git`

2. Build a Docker Image from the repository. 

For example, to create an image with the same name as the repository, from the Terminal command line:

`docker build -t trachoma-sero-transmission  trachoma-sero-transmission/`

This will take about 30 minutes to build the image because it needs to download and install R and all of the relevant package libraries.

3. Launch an instance of the image on RStudio Server

There are many ways to do this, but one example of this, from the Terminal command line:

`docker run -e USER=ben -e PASSWORD=pass --rm -p 8787:8787 -v /Users/benarnold/trachoma-sero-transmission:/home/ben trachoma-sero-transmission`

This launches the container and passes (arbitrary) credentials to RStudio Server. In this example, the Username is `ben` and the Password is `pass`. These could be anything you like -- you will just need to use them when you open your browser to access RStudio Server (next step)

4. Navigate to your web browser and go to: `http://localhost:8787`, then enter the USER and PASSWORD specified in the last step to access RStudio Server.

5. You can then run RStudio and the analysis files in a virtual instance of RStudio Server, just as you normally would on your desktop. Analyses will be run on the remote server using Linux-Ubuntu. All of the analysis scripts should run smoothly (scripts `1-xx.Rmd` to `8-xx.Rmd`). 

NOTE: we have not tested the above steps on a Windows or Linux desktop operating system (only macOS), but they should work similarly.

### Additional details

The first data processing script will download harmonized datasets from OSF and will create the final analysis datasets.

You can run the `.Rmd` notebook scripts one-by-one or you can compile [`0-trachoma-sero-transmission-run-all.R`](https://github.com/proctor-ucsf/trachoma-sero-transmission/blob/main/R/0-trachoma-sero-transmission-run-all.R), which is the file we used to run the final analyses (e.g., from the command line `R CMD BATCH 0-trachoma-sero-transmission-run-all.R &`).

The data processing and analyses on the above Mac desktop configuration required 9 minutes to run. 

After building an image on RStudio Server, all data processing and analyses required about 10 minutes to run.

Note that the only script that takes very long is `2-estimate-foi.Rmd` because estimating the hundreds of reversible catalytic models is computationally slow.

### License

This project is covered by the CC0 1.0 Universal license.
