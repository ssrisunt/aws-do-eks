#!/bin/bash

. .env


if [ "$DOCKERFILE_EXT" == "efa.dlc" ]; then
	./login.sh 763104351884.dkr.ecr.us-east-1.amazonaws.com
fi

#docker build --no-cache --progress=plain --build-arg="MODEL_NAME=$MODEL_NAME" -t ${REGISTRY}${IMAGE}${TAG} -f Dockerfile.$DOCKERFILE_EXT .
docker build --progress=plain --build-arg="MODEL_NAME=$MODEL_NAME" -t ${REGISTRY}${IMAGE}${TAG} -f Dockerfile.$DOCKERFILE_EXT .

