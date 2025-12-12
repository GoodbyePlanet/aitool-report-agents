.PHONY: all venv activate web clean help

VENV_DIR = .venv
PYTHON = python3

# Target: The default target if you just run 'make'
all: web

help:
	@echo "--- Available make commands ---"
	@grep "^##" $(MAKEFILE_LIST) | sed -E 's/## ([a-zA-Z_-]+): (.*)/\1: \2/' | column -t -s ":"

## venv: Creates the Python virtual environment if it doesn't exist.
venv:
	@if [ ! -d $(VENV_DIR) ]; then \
		echo "Creating virtual environment in $(VENV_DIR)..."; \
		$(PYTHON) -m venv $(VENV_DIR); \
		echo "Virtual environment created."; \
	else \
		echo "Virtual environment already exists in $(VENV_DIR)."; \
	fi

## web: Activates the environment and starts the ADK web server on port 8000.
web: venv
	@echo "--- Starting ADK web on port 8000 ---"
	. $(VENV_DIR)/bin/activate; adk web --port 8000

## activate: Prints the command to manually source the virtual environment.
activate: venv
	@echo "--- Activating virtual environment ---"
	@echo "Run the following command manually in your terminal:"
	@echo "source $(VENV_DIR)/bin/activate"

## clean: Removes the virtual environment directory (.venv).
clean:
	@echo "--- Removing virtual environment directory ($(VENV_DIR)) ---"
	rm -rf $(VENV_DIR)