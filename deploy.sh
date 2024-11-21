#! /bin/sh

export $(cat .env | xargs)
echo $CI_REGISTRY_TOKEN | docker login $CI_REGISTRY -u $CI_REGISTRY_USER --password-stdin
docker compose pull
docker compose up -d