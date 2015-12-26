#!/bin/bash

VERSION="5.6.16"

set -e

echo "> 1. Building Docker image"
echo ""
docker build -t donbeave/php-fpm:$VERSION .

#echo ""
#echo "> 2. Publishing Docker image to Docker Hub"
#echo ""
#docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p $DOCKER_PASS
#docker push donbeave/php-fpm:$VERSION
