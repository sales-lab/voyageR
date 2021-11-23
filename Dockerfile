# Suggested name: voyager
FROM debian:bullseye-slim

# Initial setup

COPY config/apt /tmp/apt/
RUN find /tmp/apt/ -type f -exec install --mode=644 {} /etc/apt/apt.conf.d \; \
 && rm -rf /tmp/apt \
 && sed -i '/^Templates:/a Frontend: noninteractive' /etc/debconf.conf \
 && apt-get update \
 && apt-get dist-upgrade --yes \
 && apt-get install --yes build-essential curl wget git less nano gnupg2 \
        libcurl4-openssl-dev libmagick++-dev libgmp-dev libgsl-dev \
        libfftw3-dev libudunits2-dev libgdal-dev libgmp3-dev libssl-dev \
        zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libsqlite3-dev \
        libreadline-dev libffi-dev libbz2-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# Languages

## Python
RUN apt-get update \
 && apt-get install -y python3-dev python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

## R
RUN apt-key adv --keyserver keyserver.ubuntu.com \
        --recv-key 'B8F25A8A73EACF41' \
 && echo 'deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/' \
        >/etc/apt/sources.list.d/cran.list \
 && apt-get update \
 && apt-get install --yes r-base-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


# Repositories

COPY dependencies/repos.txt /tmp/
RUN mkdir /repos \
 && cd /repos \
 && while read repo; do git clone --depth=1 "$repo"; done </tmp/repos.txt \
 && rm -f /tmp/repos.txt


# Packages

## R
COPY dependencies/r.txt /tmp/
RUN Rscript -e 'install.packages(c("BiocManager", "remotes")); \
                pkgs <- readLines("/tmp/r.txt"); \
                cpus <- as.integer(system("nproc", intern = TRUE)); \
                BiocManager::install(pkgs, ask = FALSE, Ncpus = cpus)'

RUN Rscript -e 'pkgs <- readLines("/tmp/r.txt"); \
                clean <- tolower(sub("^.*/", "", pkgs)); \
                inst <- tolower(installed.packages()[, "Package"]); \
                stopifnot(all(clean %in% inst))' \
 && rm -rf /tmp/r.txt

## Python
COPY dependencies/python.txt /tmp/
RUN pip install cython numpy
RUN pip install --no-cache-dir -r /tmp/python.txt \
 && rm -rf /tmp/python.txt

RUN cd /repos/JSTA \
 && ./install.sh

# Final setup

RUN mkdir -p /benchmark/datasets /benchmark/svgenes
COPY datasets /benchmark/datasets/
COPY svgenes /benchmark/svgenes/
COPY utils.R /benchmark/
COPY spe2seurat.R /benchmark/
COPY utils_anndata.py /benchmark/

ENV LC_ALL=C

WORKDIR /benchmark
