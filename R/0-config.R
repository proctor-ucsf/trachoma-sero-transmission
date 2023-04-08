### R configuration file -----
# for trachoma serology endgame analyses
# Christine Tedijanto christine.tedijanto@ucsf.edu
# last updated: 03/01/2022
### ----------------------

## load packages -----
# reproducibile environment
library(here)
library(renv)

# parallel computing
library(foreach)
library(doParallel)
registerDoParallel(cores = detectCores() - 1)

# general
library(tidyverse)
library(kableExtra)

# statistics
library(mgcv)
library(splines) # for bs() function
library(wCorr) # weighted correlation
library(pROC)

# figures
library(cowplot)


## quick functions -----
expit <- function(x){exp(x)/(1+exp(x))}
'%ni%' <- Negate('%in%')

## figure global aesthetics -----

# set order of location + year
location_year_name_order <- c("Alefa, Ethiopia 2017", 
                              "Andabet, Ethiopia 2017", 
                              "Dera, Ethiopia 2017", 
                              "Woreta town, Ethiopia 2017",
                              "Wag Hemra, Ethiopia (WUHA) 2016", 
                              "Wag Hemra, Ethiopia (WUHA) 2017", 
                              "Wag Hemra, Ethiopia (WUHA) 2018", 
                              "Wag Hemra, Ethiopia (WUHA) 2019",
                              "Kongwa, Tanzania 2013", 
                              "Kongwa, Tanzania 2014", 
                              "Kongwa, Tanzania 2015",
                              "Dosso, Niger (MORDOR) Spring 2015", 
                              "Dosso, Niger (MORDOR) Fall 2015", 
                              "Dosso, Niger (MORDOR) 2016",  
                              "Dosso, Niger (MORDOR) 2017",
                              "Dosso, Niger (MORDOR) 2018", 
                              "Matameye, Niger (PRET) 2013", 
                              "Kongwa, Tanzania 2018", 
                              "Wag Hemra, Ethiopia (TAITU) 2018", 
                              "Chikwawa, Malawi 2014", 
                              "Mchinji, Malawi 2014",
                              "Agdaz, Morocco 2019", 
                              "Boumalne Dades, Morocco 2019")

# set colors
# different color for each location
# within location, darker for more recent observations
# palette below based on Paul Tol's muted: https://cran.r-project.org/web/packages/khroma/vignettes/tol.html
# tool for creating color gradients: https://www.cssfontstack.com/oldsites/hexcolortool/
location_year_name_colors <- c("Alefa, Ethiopia 2017" = "#DDAA33", # yellow
                               "Andabet, Ethiopia 2017" = "#44AA99", #teal
                               "Dera, Ethiopia 2017" = "#88CCEE", # cyan 
                               "Woreta town, Ethiopia 2017" = "#CC6677", # rose
                               "Wag Hemra, Ethiopia (WUHA) 2016" = "#F791E6", 
                               "Wag Hemra, Ethiopia (WUHA) 2017" = "#C45EB3",
                               "Wag Hemra, Ethiopia (WUHA) 2018" = "#912B80", 
                               "Wag Hemra, Ethiopia (WUHA) 2019" = "#AA4499", #old version: 771166", # purple original: #AA4499
                               # "Kongwa, Tanzania 2012" = "#5EC480", 
                               "Kongwa, Tanzania 2013" = "#004400", #old version: 2B914D 
                               "Kongwa, Tanzania 2014" = "#005E1A", 
                               "Kongwa, Tanzania 2015" = "#004400", # green original: #117733
                               "Dosso, Niger (MORDOR) Spring 2015" = "#9988EE", 
                               "Dosso, Niger (MORDOR) Fall 2015" = "#6655BB", 
                               "Dosso, Niger (MORDOR) 2016" = "#4D3CA2", 
                               "Dosso, Niger (MORDOR) 2017" = "#1A096F", 
                               "Dosso, Niger (MORDOR) 2018" = "#000055", # indigo original: #332288
                               "Matameye, Niger (PRET) 2013" = "#6699CC", # light blue
                               "Kongwa, Tanzania 2018" = "#999933", # olive
                               "Wag Hemra, Ethiopia (TAITU) 2018" = "#663333", # dark red
                               "Chikwawa, Malawi 2014" = "#999999", # old version: "#BBBBBB", # gray
                               "Mchinji, Malawi 2014" = "#555555",# dark grey
                               "Agdaz, Morocco 2019" = "#F99858", # light orange (sunset palette)
                               "Boumalne Dades, Morocco 2019" = "#E34D34" #dark orange (sunset palette)
                               ) 

# set shortened names for each study population / year
location_year_name_short <- c("Alefa, Ethiopia 2017" = "Alefa, ETH",
                              "Andabet, Ethiopia 2017" = "Andabet, ETH",
                              "Dera, Ethiopia 2017" = "Dera, ETH",
                              "Woreta town, Ethiopia 2017" = "Woreta town, ETH",
                              "Wag Hemra, Ethiopia (WUHA) 2016" = "Wag Hemra, ETH (WUHA) 2016", 
                              "Wag Hemra, Ethiopia (WUHA) 2017" = "Wag Hemra, ETH (WUHA) 2017",
                              "Wag Hemra, Ethiopia (WUHA) 2018" = "Wag Hemra, ETH (WUHA) 2018", 
                              "Wag Hemra, Ethiopia (WUHA) 2019" = "Wag Hemra, ETH (WUHA)",
                              "Kongwa, Tanzania 2013" = "Kongwa, TZA 2013", 
                              "Kongwa, Tanzania 2014" = "Kongwa, TZA 2014", 
                              "Kongwa, Tanzania 2015" = "Kongwa, TZA 2015",
                              "Dosso, Niger (MORDOR) Spring 2015" = "Dosso, NER (MORDOR)", 
                              "Dosso, Niger (MORDOR) Fall 2015" = "Dosso, NER (MORDOR)", 
                              "Dosso, Niger (MORDOR) 2016" = "Dosso, NER (MORDOR)", 
                              "Dosso, Niger (MORDOR) 2017" = "Dosso, NER (MORDOR)", 
                              "Dosso, Niger (MORDOR) 2018" = "Dosso, NER (MORDOR)",
                              "Matameye, Niger (PRET) 2013" = "Matameye, NER (PRET)",
                              "Kongwa, Tanzania 2018" = "Kongwa, TZA 2018",
                              "Wag Hemra, Ethiopia (TAITU) 2018" = "Wag Hemra, ETH (TAITU)",
                              "Chikwawa, Malawi 2014" = "Chikwawa, MWI",
                              "Mchinji, Malawi 2014" = "Mchinji, MWI",
                              "Agdaz, Morocco 2019" = "Agdaz, MAR",
                              "Boumalne Dades, Morocco 2019" = "Boumalne Dades, MAR") %>% 
  as.data.frame() %>% 
  rownames_to_column()
names(location_year_name_short) <- c("location_year_name", "lyn_short")

## local file paths -----
final_data_path <- "~/Library/CloudStorage/Box-Box/trachoma-endgame/data/public-v2"

