#!/usr/bin/env Rscript

# {{ cookiecutter.project_name }} - renv Initialization Script
# This script initializes renv and installs common packages for R projects

# Load required libraries
if (!require("renv", quietly = TRUE)) {
  install.packages("renv", repos = "https://cloud.r-project.org")
}

cat("Initializing renv for {{ cookiecutter.project_name }}...\n")

# Check if renv.lock exists to determine the workflow
if (file.exists("renv.lock")) {
  # Project already has renv.lock - restore from lockfile
  cat("renv.lock found.\n")
  
} else {
  # New project - initialize renv and install default packages
  cat("No renv.lock found. Initializing new renv project...\n")
  
  # Initialize renv
  renv::init()
  cat("renv initialized successfully!\n")
  
  # Define packages to install based on cookiecutter options
  packages_to_install <- c(
    # Core R packages
    "here",
    "usethis",
    "remotes",
    "pak"
  )
  
  # Conditionally add packages based on cookiecutter selections
  {% if cookiecutter.include_tidyverse == 'y' %}
  packages_to_install <- c(packages_to_install, c(
    "tidyverse",
    "dplyr",
    "ggplot2",
    "readr",
    "tidyr",
    "stringr",
    "lubridate",
    "forcats",
    "purrr"
  ))
  {% endif %}
  
  {% if cookiecutter.include_rmarkdown == 'y' %}
  packages_to_install <- c(packages_to_install, c(
    "rmarkdown",
    "knitr",
    "bookdown",
    "blogdown",
    "xaringan",
    "pagedown",
    "flexdashboard",
    "DT",
    "reactable"
  ))
  {% endif %}
  
  {% if cookiecutter.include_shiny == 'y' %}
  packages_to_install <- c(packages_to_install, c(
    "shiny",
    "shinydashboard",
    "shinyWidgets",
    "shinycssloaders",
    "shinyjs",
    "plotly",
    "DT"
  ))
  {% endif %}
  
  {% if cookiecutter.include_plotly == 'y' %}
  packages_to_install <- c(packages_to_install, c(
    "plotly",
    "htmlwidgets",
    "crosstalk"
  ))
  {% endif %}
  
  {% if cookiecutter.include_devtools == 'y' %}
  packages_to_install <- c(packages_to_install, c(
    "devtools",
    "roxygen2",
    "pkgdown",
    "usethis"
  ))
  {% endif %}
  
  {% if cookiecutter.include_testthat == 'y' %}
  packages_to_install <- c(packages_to_install, c(
    "testthat",
    "covr",
    "mockery"
  ))
  {% endif %}
  
  {% if cookiecutter.include_lintr == 'y' %}
  packages_to_install <- c(packages_to_install, c(
    "lintr",
    "styler"
  ))
  {% endif %}
  
  # Remove duplicates
  packages_to_install <- unique(packages_to_install)
  
  # Install packages using renv
  cat("Installing packages:", paste(packages_to_install, collapse = ", "), "\n")
  
  # Install packages in batches to avoid memory issues
  batch_size <- 10
  for (i in seq(1, length(packages_to_install), batch_size)) {
    end_idx <- min(i + batch_size - 1, length(packages_to_install))
    current_batch <- packages_to_install[i:end_idx]
    
    cat("Installing batch", ceiling(i/batch_size), ":", paste(current_batch, collapse = ", "), "\n")
    
    tryCatch({
      renv::install(current_batch)
    }, error = function(e) {
      cat("Error installing batch:", e$message, "\n")
      cat("Attempting to install packages individually...\n")
      
      for (pkg in current_batch) {
        tryCatch({
          renv::install(pkg)
          cat("Successfully installed:", pkg, "\n")
        }, error = function(e) {
          cat("Failed to install:", pkg, "-", e$message, "\n")
        })
      }
    })
  }
  
  # Create snapshot
  cat("Creating renv snapshot...\n")
  renv::snapshot()
  
  cat("\nrenv initialization complete!\n")
  cat("Use 'renv::install()' to install additional packages.\n")
  cat("Use 'renv::snapshot()' to update the lockfile.\n")
}

# Print session info
cat("\nSession Info:\n")
sessionInfo()

cat("\nUseful renv commands:\n")
cat("- renv::status()    - Check package status\n")
cat("- renv::install()   - Install new packages\n")
cat("- renv::snapshot()  - Update lockfile\n")
cat("- renv::restore()   - Restore from lockfile\n")