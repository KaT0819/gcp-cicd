FROM golang:alpine-1.16 as builder

# package update
RUN apk update &&\
    apk add --no-cache git mercurial
# app copy
WORKDIR /build
COPY . /build/

# Compile
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go mod vendor
RUN go mod download
WORKDIR /build
RUN go build -a -o goapp


# multi-stage builds
FROM alpine:latest as production
RUN apk --no-cache add tzdata ca-certificates
COPY --from=builder /build/goapp /goapp

EXPOSE 8080
CMD ["/goapp"]