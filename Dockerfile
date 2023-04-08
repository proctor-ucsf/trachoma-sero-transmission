FROM rocker/rstudio:4.2.2

LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.source="https://github.com/rocker-org/rocker-versioned2" \
      org.opencontainers.image.vendor="Rocker Project" \
      org.opencontainers.image.authors="Carl Boettiger <cboettig@ropensci.org>"

# load packages using renv
RUN R -e "install.packages(c('renv'))"
WORKDIR /project
COPY renv.lock renv.lock
RUN R -e "renv::consent(provided = TRUE)"
RUN R -e "renv::restore(prompt = FALSE)"
