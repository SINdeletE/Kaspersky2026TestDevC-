DOTNET ?= dotnet
COMPOSE ?= docker compose -f docker-compose.yaml
SOLUTION := VulnerabilityTracker.slnx
API_PROJECT := src/VulnerabilityTracker.API

.DEFAULT_GOAL := build
.PHONY: up-docker up-local down build clean format test

.env: .env.example
	@if [ ! -f "$@" ]; then cp "$<" "$@"; fi

up-docker: .env
	$(COMPOSE) up --build --detach

up-local: .env
	$(DOTNET) run --project $(API_PROJECT) --launch-profile http

down: .env
	$(COMPOSE) down

build:
	$(DOTNET) build $(SOLUTION)

clean:
	$(DOTNET) clean $(SOLUTION)

format:
	$(DOTNET) format $(SOLUTION)

test:
	$(DOTNET) test $(SOLUTION)
