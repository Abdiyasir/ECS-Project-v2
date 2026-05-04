# Stage1: Build stage

FROM golang:1.24-bookworm AS builder

WORKDIR /dashboard

COPY . /dashboard 

RUN go mod tidy && go mod download

RUN go build -o dashboard main.go 

# Stage 2: Final Stage

FROM debian:bookworm-slim AS runtime

WORKDIR /dashboard

RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN chown -R appuser:appuser /dashboard

COPY --from=builder /dashboard/dashboard /dashboard/dashboard

EXPOSE 8081

CMD ["./dashboard"]
