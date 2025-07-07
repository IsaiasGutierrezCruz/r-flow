# {{ cookiecutter.project_name }} - Example Tests
# Author: {{ cookiecutter.author_name }}
# Created: {{ cookiecutter.year }}

{% if cookiecutter.include_testthat == 'y' %}
# Load testing library
library(testthat)
{% endif %}

# Load project functions (source from scripts directory)
source(here::here("scripts", "example_analysis.R"))

# Test suite for {{ cookiecutter.project_name }}
{% if cookiecutter.include_testthat == 'y' %}
test_that("Data loading function works correctly", {
  # Test data loading function
  # Create temporary test data
  temp_data <- data.frame(
    id = 1:5,
    value = c(1, 2, 3, 4, 5),
    category = c("A", "B", "A", "B", "A")
  )
  
  temp_file <- tempfile(fileext = ".csv")
  write.csv(temp_data, temp_file, row.names = FALSE)
  
  # Test loading
  expect_true(file.exists(temp_file))
  
  # Clean up
  unlink(temp_file)
})

test_that("Data processing function works correctly", {
  # Test data processing function
  test_data <- data.frame(
    id = 1:3,
    value = c(10, 20, 30),
    category = c("A", "B", "A")
  )
  
  processed <- process_data(test_data)
  
  # Check that processing adds expected columns
  expect_true("processed_date" %in% names(processed))
  expect_true("processed_by" %in% names(processed))
  
  # Check that data is preserved
  expect_equal(nrow(processed), nrow(test_data))
  expect_equal(processed$value, test_data$value)
})

test_that("Visualization function doesn't error", {
  # Test visualization function
  test_data <- data.frame(
    x = 1:5,
    y = c(1, 4, 2, 5, 3),
    category = c("A", "B", "A", "B", "A")
  )
  
  # Test that plotting function doesn't throw errors
  expect_no_error(create_example_plot(test_data))
})

test_that("Save function works correctly", {
  # Test save function
  test_object <- data.frame(x = 1:3, y = c("a", "b", "c"))
  temp_dir <- tempdir()
  
  # Mock the output path
  original_path <- output_path
  output_path <<- temp_dir
  
  # Test saving
  expect_no_error(save_output(test_object, "test_object", "rds"))
  
  # Check file exists
  expect_true(file.exists(file.path(temp_dir, "test_object.rds")))
  
  # Clean up
  unlink(file.path(temp_dir, "test_object.rds"))
  output_path <<- original_path
})

# Test mathematical functions
test_that("Basic calculations work correctly", {
  # Test basic arithmetic
  expect_equal(2 + 2, 4)
  expect_equal(5 * 3, 15)
  
  # Test statistical functions
  test_vector <- c(1, 2, 3, 4, 5)
  expect_equal(mean(test_vector), 3)
  expect_equal(sum(test_vector), 15)
})

# Test data validation
test_that("Data validation works", {
  # Test that invalid data is handled properly
  invalid_data <- data.frame(
    id = c(1, 2, NA),
    value = c(10, NA, 30)
  )
  
  # Test that we can detect missing values
  expect_true(any(is.na(invalid_data)))
  expect_equal(sum(is.na(invalid_data)), 2)
})

# Test environment setup
test_that("Environment is set up correctly", {
  # Test that required packages are available
  expect_true(require("here", quietly = TRUE))
  
  {% if cookiecutter.include_tidyverse == 'y' %}
  expect_true(require("tidyverse", quietly = TRUE))
  {% endif %}
  
  # Test that paths are set correctly
  expect_true(dir.exists(here::here()))
})

# Integration test
test_that("Full workflow runs without errors", {
  # Test that main function runs without errors
  expect_no_error(main())
})
{% else %}
# Basic tests without testthat
cat("Running basic tests...\n")

# Test 1: Data loading function
cat("Testing data loading function...\n")
temp_data <- data.frame(
  id = 1:5,
  value = c(1, 2, 3, 4, 5),
  category = c("A", "B", "A", "B", "A")
)
temp_file <- tempfile(fileext = ".csv")
write.csv(temp_data, temp_file, row.names = FALSE)
stopifnot(file.exists(temp_file))
unlink(temp_file)
cat("✓ Data loading function test passed\n")

# Test 2: Data processing function
cat("Testing data processing function...\n")
test_data <- data.frame(
  id = 1:3,
  value = c(10, 20, 30),
  category = c("A", "B", "A")
)
processed <- process_data(test_data)
stopifnot("processed_date" %in% names(processed))
stopifnot("processed_by" %in% names(processed))
stopifnot(nrow(processed) == nrow(test_data))
cat("✓ Data processing function test passed\n")

# Test 3: Basic calculations
cat("Testing basic calculations...\n")
stopifnot(2 + 2 == 4)
stopifnot(5 * 3 == 15)
test_vector <- c(1, 2, 3, 4, 5)
stopifnot(mean(test_vector) == 3)
stopifnot(sum(test_vector) == 15)
cat("✓ Basic calculations test passed\n")

cat("All tests passed! ✓\n")
{% endif %}

# Print test summary
cat("\n=== Test Summary ===\n")
cat("Project: {{ cookiecutter.project_name }}\n")
cat("Author: {{ cookiecutter.author_name }}\n")
cat("Test Date:", as.character(Sys.Date()), "\n")
cat("R Version:", R.version.string, "\n")
{% if cookiecutter.include_testthat == 'y' %}
cat("Testing Framework: testthat\n")
{% else %}
cat("Testing Framework: Base R\n")
{% endif %}
cat("==================\n") 