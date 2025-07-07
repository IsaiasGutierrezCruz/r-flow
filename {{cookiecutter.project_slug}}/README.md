# {{ cookiecutter.project_name }}

{{ cookiecutter.project_description }}

## Project Information

- **Author:** {{ cookiecutter.author_name }}
- **Email:** {{ cookiecutter.author_email }}
- **R Version:** {{ cookiecutter.r_version }}
- **Created:** {{ cookiecutter.year }}
{% if cookiecutter.license != 'None' %}
- **License:** {{ cookiecutter.license }}
{% endif %}

## 🚀 Quick Start

### Prerequisites

- Docker and Docker Compose
- Make (optional, for convenient commands)

### Getting Started

1. **Clone or download this repository**
2. **Build and start the development environment:**

```bash
make build
make up
```

3. **Access RStudio Server:**
   - Open your browser to [http://localhost:8787](http://localhost:8787)
   - Username: `rstudio`
   - Password: `{{ cookiecutter.rstudio_server_password }}`

4. **Initialize renv (first time only):**

```bash
make renv-init
```

## 📁 Project Structure

```
{{ cookiecutter.project_slug }}/
├── .devcontainer/          # VS Code dev container configuration
├── data/                   # Raw and processed data files
├── docs/                   # Documentation and reports
├── output/                 # Generated outputs (plots, tables, etc.)
├── scripts/                # R scripts and analysis files
├── tests/                  # Unit tests
├── docker-compose.yml      # Docker services configuration
├── Dockerfile             # Container image definition
├── Makefile               # Common development commands
├── .Rprofile              # R session configuration
├── .Renviron              # R environment variables
├── .gitignore             # Git ignore patterns
├── renv_init.R            # renv initialization script
└── README.md              # This file
```

## 🐳 Docker Environment

This project uses Docker for reproducible development environments with:

- **Base Image:** `rocker/verse:{{ cookiecutter.r_version }}`
- **RStudio Server:** Available at port 8787
- **Shiny Apps:** Available at port 3838
- **Persistent Volumes:** 
  - `renv_cache`: R package cache
  - `rstudio_config`: RStudio configuration
  - `r_history`: R command history
  - `.`: Working files

### Docker Commands

```bash
# Build the container
make build

# Start services
make up

# Stop services
make down

# View logs
make logs

# Open shell in container
make shell

# Clean up Docker resources
make clean-docker
```

## 📦 Package Management with renv

This project uses [renv](https://rstudio.github.io/renv/) for reproducible package management.

### renv Commands

```bash
# Initialize renv (first time)
make renv-init

# Install packages
make renv-restore

# Update lockfile
make renv-snapshot

# Check status
make renv-status

# Update packages
make renv-update
```

## 🔧 Development Workflow

### Running R Scripts

```bash
# Run a specific R script
make r-script SCRIPT=scripts/analysis.R

# Open R console
make r-console
```

### R Markdown

```bash
# Render a specific R Markdown file
make render-rmd FILE=docs/report.Rmd

# Render all R Markdown files
make render-all
```

{% if cookiecutter.include_shiny == 'y' %}
### Shiny Applications

```bash
# Run a Shiny app
make shiny-app APP=apps/dashboard.R

# Run Shiny app from directory
make shiny-dir DIR=apps/dashboard/
```
{% endif %}

### Code Quality

```bash
# Lint R code
make lint

# Format R code
make style

# Run tests
make test

# Generate test coverage
make test-coverage
```

## 🛠️ VS Code Development

This project includes VS Code dev container configuration for seamless development.

### Setup

1. Install the "Remote - Containers" extension
2. Open the project in VS Code
3. Click "Reopen in Container" when prompted

### Features

- R language support with syntax highlighting
- Integrated debugging
- Git integration
- Docker support
- Automatic port forwarding for RStudio and Shiny apps

## 📊 Available Packages

The following packages are pre-configured based on your selections:

### Core Packages
- `here` - Project-relative paths
- `usethis` - Project setup and development
- `remotes` - Package installation from various sources
- `pak` - Fast package installation

{% if cookiecutter.include_tidyverse == 'y' %}
### Tidyverse
- `tidyverse` - Data science packages
- `dplyr` - Data manipulation
- `ggplot2` - Data visualization
- `readr` - Data reading
- `tidyr` - Data tidying
{% endif %}

{% if cookiecutter.include_rmarkdown == 'y' %}
### R Markdown
- `rmarkdown` - Dynamic documents
- `knitr` - Literate programming
- `bookdown` - Authoring books
- `flexdashboard` - Interactive dashboards
{% endif %}

{% if cookiecutter.include_shiny == 'y' %}
### Shiny
- `shiny` - Interactive web applications
- `shinydashboard` - Dashboard framework
- `shinyWidgets` - Extended widgets
- `DT` - Interactive tables
{% endif %}

{% if cookiecutter.include_devtools == 'y' %}
### Development Tools
- `devtools` - Package development
- `roxygen2` - Documentation generation
- `pkgdown` - Package websites
{% endif %}

{% if cookiecutter.include_testthat == 'y' %}
### Testing
- `testthat` - Unit testing
- `covr` - Test coverage
{% endif %}

{% if cookiecutter.include_lintr == 'y' %}
### Code Quality
- `lintr` - Static code analysis
- `styler` - Code formatting
{% endif %}

## 📈 Data Management

### Data Directory Structure

```
data/
├── raw/           # Original, immutable data
├── processed/     # Cleaned and transformed data
├── interim/       # Intermediate data processing steps
└── external/      # External data sources
```

### Output Directory Structure

```
output/
├── figures/       # Generated plots and visualizations
├── tables/        # Generated tables and summaries
├── models/        # Saved model objects
└── reports/       # Generated reports
```

## 🧪 Testing

Unit tests are located in the `tests/` directory and use the `testthat` framework.

```bash
# Run all tests
make test

# Generate coverage report
make test-coverage
```

## 📚 Documentation

- Project documentation: `docs/`
- Function documentation: Generated with `roxygen2`
- Package documentation: Generated with `pkgdown`

```bash
# Generate documentation
make docs

# Serve documentation locally
make docs-serve
```

## 🔄 Continuous Integration

### GitHub Actions (Optional)

If using GitHub, consider adding CI/CD workflows:

1. R-CMD-check for package validation
2. Test coverage reporting
3. Automatic documentation deployment

## 📋 Common Tasks

### Adding New Packages

1. Install in R console: `renv::install("package_name")`
2. Update lockfile: `make renv-snapshot`
3. Commit `renv.lock` to version control

### Updating Packages

```bash
# Update all packages
make renv-update

# Update specific package
docker-compose exec r-project Rscript -e "renv::install('package_name')"
```

### Troubleshooting

#### Container Won't Start
- Check Docker daemon is running
- Verify port 8787 is not in use
- Run `make logs` to check for errors

#### Package Installation Issues
- Clear renv cache: `make clean-renv`
- Rebuild container: `make build`
- Check system dependencies in Dockerfile

#### Performance Issues
- Adjust memory limits in `docker-compose.yml`
- Use `make disk-usage` to check storage

## 📄 License

{% if cookiecutter.license != 'None' %}
This project is licensed under the {{ cookiecutter.license }} License.
{% else %}
This project is not licensed.
{% endif %}

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and linting
5. Submit a pull request

## 📞 Support

For support, please contact {{ cookiecutter.author_email }} or open an issue in the repository.

---

*Generated with [r-flow](https://github.com/IsaiasGutierrezCruz/r-flow)* 
