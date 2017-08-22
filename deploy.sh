#!/bin/bash
set -e

# Set where we're getting credentials from and for
export AWS_DEFAULT_PROFILE=yggi-api-saml
export AWS_DEFAULT_REGION=us-west-2

# Set the ECR image address
VERSION=`git describe --tags | cut -c 3-20`

if [[ ${VERSION} == *"-"* ]]
then
  echo "VERSION is a snapshot"
  VERSION=${VERSION}'-SNAPSHOT'
fi

echo "Version:              $VERSION"
echo "AWS PROFILE:          $AWS_DEFAULT_PROFILE"
echo "AWS_DEFAULT_REGION:   $AWS_DEFAULT_REGION"
echo "HOME:                 $HOME"

eval "`aws ecr get-login`"

# Run Terraform inside the hashicorp container
docker run --entrypoint="sh" \
    -w "/root" \
    -e AWS_DEFAULT_PROFILE=$AWS_DEFAULT_PROFILE \
    -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
    -v "$HOME/.aws:/root/.aws" \
    -v "`pwd`/install.sh:/root/install.sh" \
    -v "`pwd`/*:/root" \
    node:4.3 bash \
    ./install.sh
