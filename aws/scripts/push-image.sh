#!/bin/bash

if [ $# -eq 0 ]; then
  echo "No arguments provided."
else
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
    if [ "$1" == "base" ]; then
        docker build --provenance=false -t eva/base -f aws/docker/Dockerfile.Base .
        docker tag eva/base:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/eva/base:latest
        docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/eva/base:latest
    fi
    if [ "$1" == "app" ]; then
        docker build --provenance=false --build-arg APP_ENV=$ENVIRONMENT --build-arg BASE_IMAGE=$AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/eva/base:latest -t eva/app-$ENVIRONMENT -f aws/docker/Dockerfile.App .
        docker tag eva/app-$ENVIRONMENT:latest $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/eva/app-$ENVIRONMENT:latest
        docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/eva/app-$ENVIRONMENT:latest
    fi
    echo "Image pushed to Amazon ECR!"
fi
