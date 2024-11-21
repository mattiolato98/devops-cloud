#! /bin/sh

# Install docker and docker compose v2
sudo yum install docker -y
sudo service docker start
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.30.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Assign ec2-user to the group docker
sudo usermod -a -G docker ec2-user

# Install MySQL server
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo yum localinstall mysql57-community-release-el7-11.noarch.rpm 
sudo yum install mysql-community-server
sudo systemctl start mysqld.service

# Generate SSH key
ssh-keygen -t rsa
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa


