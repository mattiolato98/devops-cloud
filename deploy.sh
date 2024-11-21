#! /bin/sh

export $(cat .env | xargs)
echo $GITHUB_PERSONAL_ACCESS_TOKEN | docker login $CI_REGISTRY -u $CI_REGISTRY_USER --password-stdin
docker compose pull
