#! /bin/sh

read -p "Enter AWS public IP address: " aws_ip_address

chmod 400 ~/Downloads/labsuser.pem
ssh -o StrictHostKeyChecking=no -i ~/Downloads/labsuser.pem ec2-user@$aws_ip_address << 'ENDSSH'
  # Install docker and docker compose v2
  sudo yum install docker -y
  sudo service docker start
  DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
  mkdir -p $DOCKER_CONFIG/cli-plugins
  curl -SL https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
  chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

  # Assign ec2-user to the group docker
  sudo usermod -a -G docker ec2-user

  # Generate SSH key
  ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
  chmod 600 ~/.ssh/authorized_keys
  chmod 600 ~/.ssh/id_rsa
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

  # Create app directory
  mkdir ~/app
ENDSSH

scp -o StrictHostKeyChecking=no -i ~/Downloads/labsuser.pem ec2-user@$aws_ip_address:~/.ssh/id_rsa .

private_key=$(cat id_rsa)
rm id_rsa

ssh-add - <<< $private_key
gh secret set SSH_PRIVATE_KEY -b "$private_key"
gh secret set DJANGO_ALLOWED_HOSTS -b "$aws_ip_address"
gh secret set AWS_IP_ADDRESS -b "$aws_ip_address"

