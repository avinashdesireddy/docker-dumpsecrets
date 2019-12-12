#!/bin/sh

mkdir -p /secrets
for secret in $(find /var/run/secrets -type f -exec basename {} \;); do
  echo "Gathering secret... $secret"
  cat "/run/secrets/${secret}" > "/secrets/${secret}";
done

tar -cf /secrets/secrets.tar /secrets/*

python -m http.server 7000 --directory /secrets
