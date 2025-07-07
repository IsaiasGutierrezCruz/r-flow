# Use rocker/verse as base image for comprehensive R environment
FROM rocker/verse:{{ cookiecutter.r_version }}

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ={{ cookiecutter.timezone }}
ENV RENV_VERSION=1.0.3

# Install additional system dependencies for common R packages
RUN apt-get update && apt-get install -y \
    # System dependencies for R packages
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcairo2-dev \
    libpango1.0-dev \
    libxt-dev \
    libgdal-dev \
    libproj-dev \
    libgeos-dev \
    libudunits2-dev \
    # Additional utilities
    vim \
    htop \
    tree \
    make \
    # LaTeX packages (additional to rocker/verse)
    texlive-science \
    texlive-fonts-extra \
    lmodern \
    # For web scraping and APIs
    libsodium-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Install renv globally
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

# Install additional R packages that are commonly used
RUN R -e "install.packages(c( \
    'here', \
    'usethis', \
    'remotes', \
    'pak' \
), repos = c(CRAN = 'https://cloud.r-project.org'))"

# Create necessary directories with proper permissions
RUN mkdir -p /home/rstudio/.local/share/renv && \
    mkdir -p /home/rstudio/.config/rstudio && \
    chown -R rstudio:rstudio /home/rstudio/.local && \
    chown -R rstudio:rstudio /home/rstudio/.config

# Create renv cache directory
RUN mkdir -p /home/rstudio/.local/share/renv
RUN chown -R rstudio:rstudio /home/rstudio/.local/share/renv

# Create RStudio config directory
RUN mkdir -p /home/rstudio/.config/rstudio
RUN chown -R rstudio:rstudio /home/rstudio/.config/rstudio

# Set working directory
WORKDIR /home/rstudio/workspace

RUN chown -R rstudio:rstudio /home/rstudio/workspace

COPY renv_restore.R /home/rstudio/workspace/renv_restore.R
RUN chmod +x /home/rstudio/workspace/renv_restore.R
RUN Rscript /home/rstudio/workspace/renv_restore.R
RUN rm /home/rstudio/workspace/renv_restore.R