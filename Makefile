.PHONY: build bash db-create db-migrate db-psql db-rollback help rails-console server
DEFAULT_GOAL: help


## Build dev docker images
build:
	@docker-compose build

## Spawn bash shell in web container
bash:
	@docker-compose run --rm web bash

## Create and seed database
db-create:
	@docker-compose exec web rails db:create
	@docker-compose run web rails db:migrate
	@docker-compose exec web rails db:seed

## Execute pending migrations
db-migrate:
	@docker-compose run web rails db:migrate

## Rollback latest migration
db-rollback:
	@docker-compose run web rails db:rollback

## Run psql prompt
db-psql:
	@docker-compose exec db psql -U postgres -d postgres

## Spawn rails console
rails-console:
	@docker-compose run --rm web rails c

## Run dev stack
server:
	@docker-compose up

## Show help screen.
help:
	@echo "Please use \`make <target>' where <target> is one of\n\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
