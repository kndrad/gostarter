.PHONY: fmt review cover-html cover tests build staging sqlc docker-up docker-down

fmt:
	./scripts/format.sh

review: fmt
	./scripts/check.sh

cover:
	go test ./... -count=1 -failfast -coverprofile=coverage.out

cover-html:
	go test ./... -count=1 -failfast -coverprofile=coverage.out
	go tool cover -html=coverage.out

build:
	go build -o bin/main main.go

tests:
	go test ./... -count=1 -failfast

staging:
	./scripts/format.sh
	./scripts/check.sh
	go test ./... -count=1 -failfast -coverprofile=coverage.out

sqlc:
	sqlc generate

docker-up:
	docker-compose up --build -d

docker-down:
	docker-compose down
