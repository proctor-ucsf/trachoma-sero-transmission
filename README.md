# trachoma-sero-transmission

Monitoring transmission intensity of trachoma with serology


## Description

This repository includes R code to run all of the analysis for the paper:

_Monitoring transmission intensity of trachoma with serology_

Tedijanto et al. (in review)

Should you have any questions about the files in this repository, please contact Ben Arnold at UCSF (ben.arnold@ucsf.edu).

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

2. Recreate the exact package environment using the `renv` package. 

3. All of the analysis scripts should run smoothly (scripts `1-xx` to `8-xx`). 

### Installation Guide and Instructions for Use (Docker / RStudio Server)

The repository includes a `Dockerfile` and archive of package versions in the `renv.lock` file that you can use to build a Docker image and then launch a container on R Studio Server. 

You can download and install Docker from: https://docs.docker.com/get-docker/

To do this

1. Clone the GitHub repository to your computer

2. Build a Docker Image from the repository. 

For example, to create an image with the same name as the repository, from the command line:

`docker build -t trachoma-sero-transmission  trachoma-sero-transmission/`

This will take about 20-30 minutes to build the image because it needs to download and install R and all of the relevant package libraries.

3. Launch an instance of the image on R Studio Server

There are many ways to do this, but one example of this from the Terminal command line is:

`docker run -e USER=ben -e PASSWORD=pass --rm -p 8787:8787 -v /Users/benarnold/trachoma-sero-transmission:/home/ben trachoma-sero-transmission`

This launches the container and passes (arbitrary) credentials to RStudio Server. In this example, the Username is `ben` and the Password is `pass`. These could be anything you like -- you will just need to use them when you open your browser to access RStudio Server (next step)

4. Navigate to your web browser and go to: `http://localhost:8787` and then enter the USER ID and PASSWORD specified in the last step to access RStudio Server.

5. You can then interact with RStudio and the analysis files in a virtual instance of RStudio.

### Additional details

The first data processing script will download harmonized datasets from OSF and will create the final analysis datasets.

You can run the `.Rmd` notebook scripts one-by-one or you can compile `0-trachoma-sero-transmission-run-all.R`, which is the file we used to run the final analyses (e.g., from the command line `R CMD BATCH 0-trachoma-sero-transmission-run-all.R &`).

The data processing and analyses on the above Mac desktop configuration required 18 minutes to run. 

After building an image on RStudio Server, all data processing and analyses also required 18 minutes to run.

Note that the only script that takes very long is `2-estimate-foi.Rmd` because estimating the hundreds of reversible catalytic models is computationally slow. 

### License

This project is covered by the CC0 1.0 Universal license.
