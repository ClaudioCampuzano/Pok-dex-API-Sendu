PROJECT ?= pokedek-api
REQUIRED_BINS := docker gem

help:
	@echo "Local environment tasks:"
	@echo "  setup        Setup the environment, create containers and initialize app"
	@echo "  destroy      Clean the environment, remove volumes, containers and images"
	@echo "  shell        Run bash interactive shell on the app container"
	@echo "  console      Run rails c on the app container"
	@echo "  test         Run test on the app container"
	@echo "  serve		  Run the rails app"

setup:
	@echo ""
	@echo "Building app container image..."
	docker compose build app

	@echo ""
	@echo "Initializating database..."
	docker compose run --rm app bundle exec rails db:prepare

	@echo ""
	@echo "All is well"

serve:
	docker compose up app

shell:
	docker compose run --rm app bash

console:
	docker compose run --rm app bundle exec rails c

test:
	docker compose run --rm app rspec

destroy: check confirm
	docker compose run --rm app rails db:drop
	docker compose down --volumes
	docker rmi -f $(PROJECT)-dev:latest >/dev/null 2>&1

check:
	$(foreach bin,$(REQUIRED_BINS),\
	$(if $(shell command -v "$(bin)" 2> /dev/null),,$(error Please install `"$(bin)"`)))
	$(if $(shell docker compose 2> /dev/null),,$(error Please install docker compose v2))

confirm:
	@echo WARNING:
	@echo This command will remove all volumes from the containers.
	@echo ""
	@echo "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]