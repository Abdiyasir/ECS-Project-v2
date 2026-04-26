FROM golang:1.24-bookworm

WORKDIR /worker

COPY . /worker

RUN go mod tidy && go mod download

RUN go build -o worker main.go 

CMD ["./worker"]