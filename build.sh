#!/bin/sh

# compile disable cgo and go modules
docker run --rm -e GO111MODULE=on -e GOPROXY=https://goproxy.cn -v $PWD:/workspace 172.17.27.51/docker.io/golang:1.16 sh -c "cd /workspace && GOPATH="" CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o release/linux/arm64/drone-runner-docker"
DOCKER_IMAGE=172.17.27.51/drone/drone-runner-docker:$(date '+%Y%m%d%H%M%S')
docker build -t $DOCKER_IMAGE -f docker/Dockerfile.linux.amd64 .
docker push $DOCKER_IMAGE
docker rmi $DOCKER_IMAGE
