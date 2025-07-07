# {{ cookiecutter.project_name }} - R Profile Configuration
# This file is executed when R starts in this project directory

# Source renv if available
if (file.exists("renv/activate.R")) {
  source("renv/activate.R")
}

# Set CRAN mirror for faster package installation
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Set default options for R sessions
options(
  # General options
  width = 120,
  scipen = 6,
  digits = 4,
  
  # Package installation options
  pkgType = "both",
  
  # Development options
  warnPartialMatchArgs = TRUE,
  warnPartialMatchAttr = TRUE,
  warnPartialMatchDollar = TRUE,
  
  # Memory management
  max.print = 1000,
  
  # Parallel processing
  mc.cores = parallel::detectCores() - 1
)

# Load commonly used packages quietly
quietly_load <- function(pkg) {
  suppressPackageStartupMessages(
    suppressWarnings(
      library(pkg, character.only = TRUE, quietly = TRUE)
    )
  )
}

# Load here package for path management
if (requireNamespace("here", quietly = TRUE)) {
  quietly_load("here")
}

# Custom functions for development
cat_rule <- function(title = "", line_char = "-", width = 80) {
  if (nchar(title) > 0) {
    title <- paste0(" ", title, " ")
  }
  rule_width <- width - nchar(title)
  left_width <- floor(rule_width / 2)
  right_width <- ceiling(rule_width / 2)
  
  cat(
    paste0(
      paste(rep(line_char, left_width), collapse = ""),
      title,
      paste(rep(line_char, right_width), collapse = "")
    ),
    "\n"
  )
}

# Custom function to show project info
project_info <- function() {
  cat_rule("{{ cookiecutter.project_name }}", "=")
  cat("Project: {{ cookiecutter.project_name }}\n")
  cat("Description: {{ cookiecutter.project_description }}\n")
  cat("Author: {{ cookiecutter.author_name }}\n")
  cat("R Version: {{ cookiecutter.r_version }}\n")
  cat("Working Directory:", getwd(), "\n")
  
  if (file.exists("renv.lock")) {
    cat("renv Status: Activated\n")
  } else {
    cat("renv Status: Not initialized\n")
  }
  
  cat_rule("", "=")
}

# Display project info on startup
if (interactive()) {
  project_info()
  
  # Show helpful commands
  cat("\nUseful commands:\n")
  cat("  project_info()     - Show project information\n")
  cat("  renv::status()     - Check renv status\n")
  cat("  renv::install()    - Install packages\n")
  cat("  renv::snapshot()   - Update lockfile\n")
  cat("  renv::restore()    - Restore packages\n")
  cat("  sessionInfo()      - Show session information\n")
  cat("\nFor more commands, check the Makefile or run 'make help'\n\n")
}

# Set up custom error handling for development
if (interactive()) {
  options(error = recover)
}
