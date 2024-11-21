#! /bin/sh

ssh -o StrictHostKeyChecking=no ec2-user@$AWS_IP_ADDRESS << 'ENDSSH'
  export $(cat .env | xargs)
  echo $CI_REGISTRY_TOKEN | docker login $CI_REGISTRY -u $CI_REGISTRY_USER --password-stdin
  docker compose pull
  docker compose up -d
ENDSSH