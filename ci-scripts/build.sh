#!/bin/sh

if [ ! -z ${BASH_SOURCE} ]; then
  BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
  BIN_DIR=$(dirname "$(readlink -f "$0")")
fi

IMAGE_TAG=$(git log HEAD -n1 --format=%h)

DOCKER_REGISTRY="${DOCKER_REGISTRY:-654654392712.dkr.ecr.us-east-1.amazonaws.com}"
PYTHON_IMAGE=${DOCKER_REGISTRY}/challenge:${IMAGE_TAG}
echo Using repository $DOCKER_REGISTRY and tag $IMAGE_TAG

set -e
docker build -t ${PYTHON_IMAGE} -f ${BIN_DIR}/../Dockerfile --build-arg CONTAINER_REGISTRY=${DOCKER_REGISTRY} .

docker push ${PYTHON_IMAGE}
