#!/bin/bash -e

REVISION=$(git rev-parse HEAD)

build_docker_image () {
  docker build --tag "thegreenrobot/alpine-ansible-python3" --file ./Dockerfile .
  docker tag thegreenrobot/alpine-ansible-python3:latest thegreenrobot/alpine-ansible-python3:$REVISION
}

upload_docker_image () {
  docker push thegreenrobot/alpine-ansible-python3:latest
  docker push thegreenrobot/alpine-ansible-python3:$REVISION
}

echo "Building docker image..."
build_docker_image
echo "Uploading docker image..."
upload_docker_image
echo "Success!"
