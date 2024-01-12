FROM r-base

MAINTAINER Pachka Hammami "pachka@hotmail.fr"

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    software-properties-common \
    gpg-agent

RUN apt-get update && apt-get install -y \
    pandoc \
    libcurl4-openssl-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl3 \
    libgit2-dev \
    libxml2-dev \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \ 
    libproj-dev \
    libharfbuzz-dev \
    libfribidi-dev

# basic dev libraries
RUN R -e "install.packages('devtools')" 

## R package dependencies
## Install la derniere version de renv
#RUN Rscript -e "if (!requireNamespace('renv', quietly = TRUE, repos='https//cloud.r-project.org')) install.packages('renv')"
## Install la version de renv utilise
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
RUN R -e "remotes::install_version('renv',version='1.0.3', repos=c(CRAN = 'https://cloud.r-project.org'))"
RUN Rscript -e "options(renv.config.cache.symlinks = FALSE); renv::deactivate(); renv::restore()"

RUN mkdir /root/mwss
COPY . /root/mwss

EXPOSE 3838

