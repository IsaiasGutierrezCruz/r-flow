#!/usr/bin/env Rscript

# Load required libraries
if (!require("renv", quietly = TRUE)) {
  install.packages("renv", repos = "https://cloud.r-project.org")
}

# Check if renv.lock exists to determine the workflow
if (file.exists("renv.lock")) {
  # Project already has renv.lock - restore from lockfile
  cat("renv.lock found. Restoring packages from lockfile...\n")
  
  # Activate renv if not already activated
  if (!renv:::renv_project_loaded()) {
    renv::activate()
    cat("renv activated successfully!\n")
  }
  
  # Restore packages from lockfile
  tryCatch({
    renv::restore()
    cat("Packages restored successfully from renv.lock!\n")
  }, error = function(e) {
    cat("Error restoring packages:", e$message, "\n")
    cat("You may need to run 'renv::restore()' manually.\n")
  })
  
} else {
  cat("No renv.lock found. Skipping initialization...\n")
}

cat("\nUseful renv commands:\n")
cat("- renv::status()    - Check package status\n")
cat("- renv::install()   - Install new packages\n")
cat("- renv::snapshot()  - Update lockfile\n")
cat("- renv::restore()   - Restore from lockfile\n")