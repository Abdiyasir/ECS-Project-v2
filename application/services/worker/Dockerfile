# Stage1: Build stage

FROM golang:1.24-bookworm AS builder

WORKDIR /worker

COPY . /worker

RUN go mod tidy && go mod download

RUN go build -o worker main.go 

# Stage 2: Final Stage

FROM debian:bookworm-slim AS runtime

WORKDIR /worker

# Install trusted CA certificates
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN chown -R appuser:appuser /worker

COPY --from=builder /worker/worker /worker/worker

CMD ["./worker"]