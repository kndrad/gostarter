.PHONY: fmt
fmt:
	./scripts/format.sh

.PHONY: cover
cover:
	go test ./... -count=1 -failfast -coverprofile=coverage.out

.PHONY: cover-html
cover-html:
	go test ./... -count=1 -failfast -coverprofile=coverage.out
	go tool cover -html=coverage.out

.PHONY: build
build:
	go build -o bin/main main.go

.PHONY: tests
tests:
	go test ./... -count=1 -failfast

.PHONY: review
review:
	./scripts/format.sh
	./scripts/check.sh
	go test ./... -count=1 -failfast -coverprofile=coverage.out

.PHONY: sqlc
sqlc:
	sqlc generate

.PHONY: docker-up
docker-up:
	docker-compose up --build -d

.PHONY: docker-down
docker-down:
	docker-compose down

.PHONY: docker-rmv
docker-rmv:
	docker-compose down -v

POSTGRES_URL = ""

.PHONY: migrate-up
migrate-up:
	migrate -database $(POSTGRES_URL) -path db/migrations up

.PHONY: migrate-down
migrate-down:
	migrate -database $(POSTGRES_URL) -path db/migrations down

.PHONY: migrate-version
migrate-version:
	migrate -database $(POSTGRES_URL) -path db/migrations version
