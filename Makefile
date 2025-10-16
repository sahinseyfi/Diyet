PY := python3
VENV := .venv
PIP := $(VENV)/bin/pip
PYTHON := $(VENV)/bin/python

.PHONY: venv install fmt lint test test-cov check bootstrap sentry-dsn

venv:
	@test -d $(VENV) || $(PY) -m venv $(VENV)
	@. $(VENV)/bin/activate && $(PIP) install --upgrade pip

install: venv
	@$(PIP) install -r requirements.txt

fmt:
	@$(VENV)/bin/black .

lint:
	@$(VENV)/bin/ruff check .

test:
	@$(PYTHON) -m pytest

test-cov:
	@$(PYTHON) -m pytest --cov=src --cov-report=term-missing --cov-fail-under=90

check: fmt lint test

bootstrap:
	bash scripts/bootstrap.sh

sentry-dsn:
	bash scripts/sentry_dsn.sh
