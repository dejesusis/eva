#!/bin/bash

export AWS_DEFAULT_PROFILE=eva
export AWS_ACCOUNT_ID="<Replace with AWS Account ID>"
export ENVIRONMENT='stage'

if [ $# -eq 0 ]; then
  echo "No arguments provided."
else
    if [ "$1" == "image" ]; then
        chmod +x ./aws/scripts/push-image.sh
        ./aws/scripts/push-image.sh $2
        echo "Done!"
    fi
fi