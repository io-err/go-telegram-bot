APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := ioerr
VERSION=$(shell git rev-parse --short HEAD)
TARGETOS=linux 
TARGETARCH=amd64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o go-telegram-bot -ldflags "-X="github.com/IO-Err/go-telegram-bot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}  --build-arg TARGETARCH=${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

linux: build image 
  TARGETOS=linux
  
arm: build image
  TARGETARCH=arm64

windows: build image
  TARGETOS=windows

clean:
	rm go-telegram-bot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}