# r-flow

A comprehensive cookiecutter template for creating reproducible R projects with Docker, renv, and modern development tools.

## Features ✨

- **Docker Environment**: Uses `rocker/verse` for comprehensive R development
- **Package Management**: Integrated `renv` for reproducible package environments
- **Development Tools**: 
  - VS Code dev containers support
  - RStudio Server integration
  - Comprehensive Makefile for common tasks
- **Code Quality**: Built-in linting, formatting, and testing
- **Reproducibility**: Docker containers with persistent volumes
- **Flexibility**: Customizable project structure and dependencies

## Prerequisites 📋

- [Cookiecutter](https://github.com/cookiecutter/cookiecutter) (`pip install cookiecutter`)
- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)
- [Make](https://www.gnu.org/software/make/) (optional, for convenient commands)

## Usage 🚀

### Creating a New Project

```bash
# Using cookiecutter directly
cookiecutter https://github.com/IsaiasGutierrezCruz/r-flow
```

### Template Variables

The template will prompt you for the following variables:

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `project_name` | Human-readable project name | `my-r-project` | `Advanced Data Analysis` |
| `project_slug` | Project directory name | Auto-generated | `advanced-data-analysis` |
| `project_description` | Brief project description | `A reproducible R project...` | `Statistical analysis of customer data` |
| `author_name` | Your name | `Your Name` | `John Doe` |
| `author_email` | Your email | `your.email@example.com` | `john.doe@company.com` |
| `r_version` | R version for Docker | `4.3.2` | `4.3.2` |
| `use_git` | Initialize git repo | `y` | `y` or `n` |
| `use_github` | Set up GitHub remote | `y` | `y` or `n` |
| `github_username` | GitHub username | `yourusername` | `johndoe` |
| `license` | License type | `MIT` | `MIT`, `GPL-3`, `Apache-2.0`, `BSD-3-Clause`, `None` |
| `include_shiny` | Include Shiny packages | `y` | `y` or `n` |
| `include_rmarkdown` | Include R Markdown packages | `y` | `y` or `n` |
| `include_plotly` | Include Plotly packages | `y` | `y` or `n` |
| `include_tidyverse` | Include Tidyverse packages | `y` | `y` or `n` |
| `include_devtools` | Include development tools | `y` | `y` or `n` |
| `include_testthat` | Include testing framework | `y` | `y` or `n` |
| `include_lintr` | Include code quality tools | `y` | `y` or `n` |
| `rstudio_server_password` | RStudio Server password | `password123` | `mysecretpassword` |
| `timezone` | Container timezone | `UTC` | `America/New_York` |

## Generated Project Structure 📁

```
your-project/
├── .devcontainer/          # VS Code dev container configuration
│   └── devcontainer.json
├── data/                   # Data files (raw, processed, etc.)
│   ├── raw/
│   ├── processed/
│   ├── interim/
│   └── external/
├── docs/                   # Documentation and reports
│   └── example_report.Rmd
├── output/                 # Generated outputs
│   ├── figures/
│   ├── tables/
│   ├── models/
│   └── reports/
├── scripts/                # R scripts
│   └── example_analysis.R
├── tests/                  # Unit tests
│   └── test_example.R
├── docker-compose.yml      # Docker services configuration
├── Dockerfile             # Container image definition
├── Makefile               # Development commands
├── .Rprofile              # R session configuration
├── .Renviron              # R environment variables
├── .gitignore             # Git ignore patterns
├── renv_init.R            # renv initialization script
├── renv_restore.R         # renv restoring dependencies script
├── README.md              # Project documentation
└── LICENSE                # License file (if specified)
```

## Development Workflow 🔄

### 1. Initial Setup

```bash
# Navigate to your project
cd your-project

# Build the Docker environment
make build # then Open your browser to http://localhost:8787

# Start the development environment
make up
```

### 2. Access Development Tools

```bash
# Access R console
make r-console

# Open shell in container
make shell
```

### 3. Package Management

```bash
# Initialize renv (first time only)
make renv-init

# Snapshot current packages
make renv-snapshot

# Restore packages from lockfile
make renv-restore

# Check renv status
make renv-status
```

### 4. Development Commands

```bash
# Run R script
make r-script SCRIPT=scripts/analysis.R

# Render R Markdown
make render-rmd FILE=docs/report.Rmd

# Run Shiny app
make shiny-app APP=app.R

# Check code quality
make lint

# Run tests
make test
```

## Docker Configuration 🐳

The template uses Docker for reproducible environments with:

### Base Image
- `rocker/verse:R_VERSION` - Comprehensive R environment with RStudio Server

### Persistent Volumes
- `renv_cache` - R package cache for faster installations
- `rstudio_config` - RStudio Server configuration
- `r_history` - R command history

### Ports
- `8787` - RStudio Server
- `3838` - Shiny applications

### Environment Variables
- Configurable through `.Renviron` file
- Docker-specific settings for optimal performance

## VS Code Integration 💻

The template includes complete VS Code dev container configuration:

### Features
- R language support with syntax highlighting
- Integrated debugging and testing
- Git integration
- Docker support
- Automatic port forwarding
- Comprehensive extension pack

### Setup
1. Install "Remote - Containers" extension
2. Open project in VS Code
3. Click "Reopen in Container"
4. Wait for container to build and start

## Package Management with renv 📦

The template integrates `renv` for reproducible package management:

### Key Features
- Isolated package libraries per project
- Lockfile for exact package versions
- Shared cache for faster installations
- Automatic restoration in Docker

### Bootstrap Process
1. Container starts with base packages
2. `renv_init.R` initializes renv if no lockfile exists
3. Installs packages based on template selections
4. Creates initial lockfile

## Testing Framework 🧪

The template includes comprehensive testing setup:

### testthat Integration
- Unit tests in `tests/` directory
- Example tests for common functions

### Test Commands
```bash
# Run all tests
make test

# Generate coverage report
make test-coverage

# Lint code
make lint

# Format code
make style
```

## Makefile Commands 🔧

The template includes a comprehensive Makefile with 40+ commands:

### Container Management
- `make build` - Build Docker container
- `make up` - Start development environment
- `make down` - Stop containers
- `make logs` - View container logs

### Development
- `make r-console` - Open R console
- `make rstudio` - Open RStudio Server
- `make shell` - Open container shell

### Package Management
- `make renv-init` - Initialize renv
- `make renv-snapshot` - Update lockfile
- `make renv-restore` - Restore packages

### Code Quality
- `make lint` - Run code linting
- `make style` - Format code
- `make test` - Run unit tests

### Data Processing
- `make r-script SCRIPT=file.R` - Run R script
- `make render-rmd FILE=report.Rmd` - Render R Markdown
- `make shiny-app APP=app.R` - Run Shiny app
- `make run-rmd-shiny-file FILE=report.Rmd` - Run shiny app based on a rmd file
- `make run-rmd-shiny-file-pre-rendered FILE=report.Rmd` - Run shiny app with a pre-rendered rmd file.

## Customization Options 🎨

### Adding New Packages
1. Modify `renv_init.R` to include additional packages
2. Update Dockerfile if system dependencies are needed
3. Add to cookiecutter.json if it should be optional

### Modifying Docker Configuration
1. Edit `Dockerfile` for system-level changes
2. Update `docker-compose.yml` for service configuration
3. Modify `.devcontainer/devcontainer.json` for VS Code settings

### Extending the Makefile
1. Add new targets to `Makefile`
2. Follow existing patterns for consistency
3. Include help text with `##` comments

## Best Practices 📋

### Project Organization
- Keep raw data immutable in `data/raw/`
- Use `here::here()` for file paths
- Document data sources and transformations
- Use meaningful file and variable names

### Code Quality
- Run `make lint` before committing
- Write tests for critical functions
- Use consistent coding style
- Document complex algorithms

### Reproducibility
- Always commit `renv.lock` file
- Use Docker for consistent environments
- Document system dependencies
- Include session information in reports

### Git Workflow
- Use meaningful commit messages
- Keep commits focused and atomic
- Use branches for feature development
- Tag releases with version numbers

## Troubleshooting 🔍

### Common Issues

#### Container won't start
- Check if Docker daemon is running
- Verify ports 8787 and 3838 are available
- Run `make logs` to check for errors

#### Package installation fails
- Check system dependencies in Dockerfile
- Clear renv cache with `make clean-renv`
- Rebuild container with `make build`

#### RStudio Server not accessible
- Verify container is running: `docker ps`
- Check port forwarding: `make logs`
- Try different browser or incognito mode

#### Performance issues
- Use `make disk-usage` to check storage
- Consider using faster storage for Docker

### Getting Help
- Check project README.md
- Run `make help` for available commands
- Check container logs with `make logs`
- Review Docker and renv documentation

## Contributing 🤝

To contribute to this template:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with different configurations
5. Submit a pull request

### Template Development
- Test template generation with various options
- Ensure all generated files are valid
- Update documentation for new features
- Add examples for complex features

## License 📄

This template is licensed under the MIT License. Projects generated from this template can use any license specified during generation.

## Acknowledgments 🙏

This template is built on the shoulders of giants:

- [Cookiecutter](https://github.com/cookiecutter/cookiecutter) - Template engine
- [Rocker Project](https://rocker-project.org/) - Docker images for R
- [renv](https://rstudio.github.io/renv/) - Package management
- [RStudio](https://rstudio.com/) - IDE and tools
- [tidyverse](https://tidyverse.org/) - Data science packages

---

*Happy coding! 🚀* 