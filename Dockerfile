# Suggested name: voyager
FROM debian:bullseye-slim

# Initial setup
COPY config/apt /tmp/apt/
RUN find /tmp/apt/ -type f -exec install --mode=644 {} /etc/apt/apt.conf.d \; \
 && rm -rf /tmp/apt \
 && sed -i '/^Templates:/a Frontend: noninteractive' /etc/debconf.conf \
 && apt-get update \
 && apt-get dist-upgrade --yes \
 && apt-get install --yes build-essential gfortran curl wget git less nano gnupg2 time collectl \
        libcurl4-openssl-dev libmagick++-dev libgmp-dev libgsl-dev \
        libfftw3-dev libudunits2-dev libgdal-dev libgmp3-dev libssl-dev \
        zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libsqlite3-dev \
        libreadline-dev libffi-dev libbz2-dev tmux python3-dev python3-pip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

## R-BASE Setup
RUN apt-key adv --keyserver keyserver.ubuntu.com \
        --recv-key 'B8F25A8A73EACF41' \
 && echo 'deb http://cloud.r-project.org/bin/linux/debian bullseye-cran40/' \
        >/etc/apt/sources.list.d/cran.list \
 && apt-get update \
 && apt-get install --yes r-base-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

## Folder setup
RUN mkdir -p /repos /benchmark/datasets /benchmark/svgenes /results/svgenes 

RUN chmod a+rwX /benchmark/datasets
RUN chmod a+rwX /results

## REPOS
COPY dependencies/repos.txt /tmp/
RUN cd /repos \
 && while read repo; do git clone --depth=1 "$repo"; done </tmp/repos.txt \
 && rm -f /tmp/repos.txt

## PYTHON
COPY dependencies/python.txt /tmp/
RUN opts="--no-cache-dir" \
 && pip install -U $opts pip \
 && pip install -U $opts setuptools wheel \
 && pip install -U $opts cython numpy

RUN opts="--no-cache-dir" \
 && echo "numpy >= 1.22.3" >/tmp/constraints.txt \
 && pip install $opts -r /tmp/python.txt --constraint /tmp/constraints.txt \
 && rm /tmp/constraints.txt

## R
COPY dependencies/r.txt /tmp/
RUN Rscript -e 'install.packages(c("BiocManager", "remotes")); \
                pkgs <- readLines("/tmp/r.txt"); \
                cpus <- as.integer(system("nproc", intern = TRUE)); \
                BiocManager::install(pkgs, ask = FALSE, Ncpus = cpus)'

RUN Rscript -e 'BiocManager::install("jbergenstrahle/STUtility", ask = FALSE)'

RUN Rscript -e 'pkgs <- readLines("/tmp/r.txt"); \
                clean <- tolower(sub("^.*/", "", pkgs)); \
                inst <- tolower(installed.packages()[, "Package"]); \
                for (p in clean){ if(!(p %in% inst)){ print(paste0(p, " --> Not Installed"))} }; \
                stopifnot(all(clean %in% inst))' \
 && rm -rf /tmp/r.txt


RUN cd /repos/JSTA \
 && ./install.sh

COPY svgenes /benchmark/svgenes/

COPY utils.R /benchmark/
COPY spe2seurat.R /benchmark/
COPY utils_anndata.py /benchmark/
COPY benchmark_svgenes.py /benchmark/

RUN find /benchmark \( -name '*.sh'  -or -name '*.py' -or -name '*.R' \) -exec chmod 755 {} \;

ENV LC_ALL=C

WORKDIR /benchmark
