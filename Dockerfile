FROM golang:1.23.2-alpine AS builder

WORKDIR /
RUN apk add --no-cache git

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main ./

# FINAL
FROM alpine:3.20.3

WORKDIR /
COPY --from=builder /app/main /main

ENTRYPOINT [ "./main" ]
# uncomment below if you want to display help
# CMD [ "--help" ]
