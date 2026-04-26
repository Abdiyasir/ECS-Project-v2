FROM golang:1.24-bookworm

WORKDIR /dashboard

COPY . /dashboard 

RUN go mod tidy && go mod download

RUN go build -o dashboard main.go 

EXPOSE 8001

CMD ["./dashboard"]
