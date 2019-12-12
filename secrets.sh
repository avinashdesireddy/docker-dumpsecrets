#!/usr/bin/env bash

PUBLISH_PORT=8080
allsecrets=($(docker secret ls --format '{{printf "%s " .Name}}' | tr -d '\n'))
echo ${allsecrets[@]}

echo "Deleting existing service"
docker service rm dumpsecrets

echo ""
echo "Creating service"
docker service create \
  $(for secret in "${allsecrets[@]}";
    do echo --secret $secret;
  done) \
  --name dumpsecrets \
  --publish published=${PUBLISH_PORT},target=7000 \
avinashdesireddy/dumpsecrets:latest

echo "Service started..."
echo "Navigate to https://<UCP_URL>:${PUBLISH_PORT} and download tarfile"

##--mount source=dumpsecrets,target=/secrets \
