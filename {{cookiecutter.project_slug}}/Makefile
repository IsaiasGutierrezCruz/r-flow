# {{ cookiecutter.project_name }} - Makefile
# Common commands for R development workflow

# Variables
COMPOSE_FILE := docker-compose.yml
SERVICE_NAME := r-project
CONTAINER_NAME := {{ cookiecutter.project_slug }}-dev
R_FILES := $(shell find . -name "*.R" -not -path "./renv/*")
RMD_FILES := $(shell find . -name "*.Rmd")

# Default target
.PHONY: help
help: ## Show this help message
	@echo "{{ cookiecutter.project_name }} - Available commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Container management
.PHONY: build
build: ## Build the Docker container
	docker-compose -f $(COMPOSE_FILE) build

.PHONY: up
up: ## Start the development container
	docker-compose -f $(COMPOSE_FILE) up -d

.PHONY: down
down: ## Stop and remove containers
	docker-compose -f $(COMPOSE_FILE) down

.PHONY: restart
restart: down up ## Restart the development container

.PHONY: logs
logs: ## Show container logs
	docker-compose -f $(COMPOSE_FILE) logs -f

.PHONY: shell
shell: ## Open a shell in the container
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) bash


# R development commands
.PHONY: r-console
r-console: ## Open R console in container
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) R --no-save --no-restore

.PHONY: r-script
r-script: ## Run an R script (usage: make r-script SCRIPT=script.R)
	@if [ -z "$(SCRIPT)" ]; then echo "Usage: make r-script SCRIPT=script.R"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript $(SCRIPT)

.PHONY: render-rmd
render-rmd: ## Render R Markdown file (usage: make render-rmd FILE=report.Rmd)
	@if [ -z "$(FILE)" ]; then echo "Usage: make render-rmd FILE=report.Rmd"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "rmarkdown::render('$(FILE)')"

.PHONY: render-all
render-all: ## Render all R Markdown files
	@for file in $(RMD_FILES); do \
		echo "Rendering $$file..."; \
		docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "rmarkdown::render('$$file')"; \
	done

.PHONY: run-rmd-shiny-file
run-rmd-shiny-file: ## Run R Markdown file as Shiny app (usage: make run-rmd-shiny-file FILE=report.Rmd)
	@if [ -z "$(FILE)" ]; then echo "Usage: make run-rmd-shiny-file FILE=report.Rmd"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "library(shiny); rmarkdown::run('$(FILE)', shiny_args = list(port = 3838, host = '0.0.0.0'))"

.PHONY: run-rmd-shiny-file-pre-rendered
run-rmd-shiny-file-pre-rendered: ## Run R Markdown file as Shiny app (usage: make run-rmd-shiny-file-pre-rendered FILE=report.Rmd)
	@if [ -z "$(FILE)" ]; then echo "Usage: make run-rmd-shiny-file-pre-rendered FILE=report.Rmd"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "library(shiny); rmarkdown::render('$(FILE)'); rmarkdown::run('$(FILE)', shiny_args = list(port = 3838, host = '0.0.0.0'))"

.PHONY: shiny-app
shiny-app: ## Run a Shiny app (usage: make shiny-app APP=app.R)
	@if [ -z "$(APP)" ]; then echo "Usage: make shiny-app APP=app.R"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "shiny::runApp('$(APP)', host='0.0.0.0', port=3838)"

.PHONY: shiny-dir
shiny-dir: ## Run Shiny app from directory (usage: make shiny-dir DIR=./shiny-app)
	@if [ -z "$(DIR)" ]; then echo "Usage: make shiny-dir DIR=./shiny-app"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "shiny::runApp('$(DIR)', host='0.0.0.0', port=3838)"

# Package management with renv
.PHONY: renv-init
renv-init: ## Initialize renv for the project
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript renv_init.R

.PHONY: renv-snapshot
renv-snapshot: ## Create renv.lock snapshot
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "renv::snapshot()"

.PHONY: renv-restore
renv-restore: ## Restore packages from renv.lock
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "renv::restore()"

.PHONY: renv-update
renv-update: ## Update all packages in renv
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "renv::update()"

.PHONY: renv-status
renv-status: ## Check renv status
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "renv::status()"

# Code quality and testing
.PHONY: lint
lint: ## Run lintr on R files
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "lintr::lint_dir()"

.PHONY: lint-file
lint-file: ## Lint a specific R file (usage: make lint-file FILE=script.R)
	@if [ -z "$(FILE)" ]; then echo "Usage: make lint-file FILE=script.R"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "lintr::lint('$(FILE)')"

.PHONY: style
style: ## Style R files using styler
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "styler::style_dir()"

.PHONY: style-file
style-file: ## Style a specific R file (usage: make style-file FILE=script.R)
	@if [ -z "$(FILE)" ]; then echo "Usage: make style-file FILE=script.R"; exit 1; fi
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "styler::style_file('$(FILE)')"

.PHONY: test
test: ## Run tests using testthat
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "testthat::test_dir('tests')"

.PHONY: test-coverage
test-coverage: ## Generate test coverage report
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "covr::report()"

# Data and output management
.PHONY: clean-output
clean-output: ## Clean output files
	rm -rf output/*
	rm -f *.html *.pdf *.docx

.PHONY: clean-cache
clean-cache: ## Clean R cache and temporary files
	rm -f .RData .Rhistory
	rm -rf .Rproj.user/

.PHONY: clean-renv
clean-renv: ## Clean renv cache
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "renv::clean()"

.PHONY: clean-all
clean-all: clean-output clean-cache ## Clean all generated files

# Documentation
.PHONY: docs
docs: ## Generate documentation using pkgdown
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "pkgdown::build_site()"

.PHONY: docs-serve
docs-serve: ## Serve documentation locally
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "pkgdown::preview_site()"

# Batch processing
.PHONY: batch
batch: ## Run batch processing container
	docker-compose -f $(COMPOSE_FILE) --profile batch up $(SERVICE_NAME)-batch

.PHONY: check-system
check-system: ## Check system requirements
	docker-compose -f $(COMPOSE_FILE) exec $(SERVICE_NAME) Rscript -e "sessionInfo()"

.PHONY: disk-usage
disk-usage: ## Show disk usage of containers and volumes
	docker system df
	docker volume ls

# Cleanup
.PHONY: clean-docker
clean-docker: ## Clean Docker resources
	docker-compose -f $(COMPOSE_FILE) down -v --remove-orphans
	install-depsocker system prune -f 