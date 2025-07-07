# {{ cookiecutter.project_name }} - Example Analysis Script
# Author: {{ cookiecutter.author_name }}
# Created: {{ cookiecutter.year }}

# Load required libraries
library(here)
{% if cookiecutter.include_tidyverse == 'y' %}
library(tidyverse)
{% endif %}
{% if cookiecutter.include_rmarkdown == 'y' %}
library(rmarkdown)
{% endif %}

# Set up paths using here package
data_path <- here("data", "raw")
output_path <- here("output", "figures")
processed_path <- here("data", "processed")

# Create output directories if they don't exist
dir.create(output_path, recursive = TRUE, showWarnings = FALSE)
dir.create(processed_path, recursive = TRUE, showWarnings = FALSE)

# Example data loading function
load_data <- function(filename) {
  file_path <- here(data_path, filename)
  if (file.exists(file_path)) {
    # Detect file type and load accordingly
    if (tools::file_ext(filename) == "csv") {
      {% if cookiecutter.include_tidyverse == 'y' %}
      return(readr::read_csv(file_path))
      {% else %}
      return(read.csv(file_path))
      {% endif %}
    } else if (tools::file_ext(filename) == "rds") {
      return(readRDS(file_path))
    } else {
      stop("Unsupported file type")
    }
  } else {
    stop(paste("File not found:", filename))
  }
}

# Example data processing function
process_data <- function(data) {
  # Add your data processing logic here
  {% if cookiecutter.include_tidyverse == 'y' %}
  processed_data <- data %>%
    # Example transformations
    janitor::clean_names() %>%
    dplyr::filter(!is.na(.data[[1]])) %>%
    dplyr::mutate(
      processed_date = Sys.Date(),
      processed_by = "{{ cookiecutter.author_name }}"
    )
  {% else %}
  # Basic R processing example
  processed_data <- data
  processed_data$processed_date <- Sys.Date()
  processed_data$processed_by <- "{{ cookiecutter.author_name }}"
  {% endif %}
  
  return(processed_data)
}

# Example visualization function
create_example_plot <- function(data) {
  {% if cookiecutter.include_tidyverse == 'y' %}
  # Create a simple plot with ggplot2
  plot <- ggplot(data, aes(x = 1, y = 1)) +
    geom_point() +
    labs(
      title = "{{ cookiecutter.project_name }}",
      subtitle = "Example Plot",
      caption = paste("Created by:", "{{ cookiecutter.author_name }}")
    ) +
    theme_minimal()
  {% else %}
  # Create a simple base R plot
  plot(1, 1, main = "{{ cookiecutter.project_name }}", 
       xlab = "X", ylab = "Y")
  {% endif %}
  
  return(plot)
}

# Example save function
save_output <- function(object, filename, type = "rds") {
  if (type == "rds") {
    saveRDS(object, here(output_path, paste0(filename, ".rds")))
  } else if (type == "csv") {
    {% if cookiecutter.include_tidyverse == 'y' %}
    readr::write_csv(object, here(output_path, paste0(filename, ".csv")))
    {% else %}
    write.csv(object, here(output_path, paste0(filename, ".csv")), row.names = FALSE)
    {% endif %}
  }
  
  cat("Saved:", filename, "to", output_path, "\n")
}

# Main analysis workflow
main <- function() {
  cat("Starting {{ cookiecutter.project_name }} analysis...\n")
  
  # Example workflow
  tryCatch({
    # Step 1: Load data (uncomment when you have data)
    # raw_data <- load_data("example_data.csv")
    
    # Step 2: Process data
    # processed_data <- process_data(raw_data)
    
    # Step 3: Create visualizations
    # plot <- create_example_plot(processed_data)
    
    # Step 4: Save outputs
    # save_output(processed_data, "processed_data", "csv")
    # save_output(plot, "example_plot")
    
    cat("Analysis completed successfully!\n")
    
  }, error = function(e) {
    cat("Error in analysis:", e$message, "\n")
  })
}

# Execute main function if script is run directly
if (sys.nframe() == 0) {
  main()
}

# Session information
cat("\nSession Info:\n")
sessionInfo() 