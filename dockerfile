FROM golang:alpine as build-env

# this indicates that we will be using go mods
ENV GO111MODULE=on

# install some packages we will need
RUN apk update && apk add bash ca-certificates git gcc g++ libc-dev

RUN mkdir /proto_example
RUN mkdir -p /proto_example/proto

WORKDIR /proto_example

COPY ./proto/service.pb.go /proto_example/proto
COPY ./main.go /proto_example

# the . will copy to the workdir which we are already in
COPY go.mod .
COPY go.sum .

RUN go mod download

RUN go build -o proto_example .

CMD ./proto_example
