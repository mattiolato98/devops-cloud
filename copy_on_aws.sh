#! /bin/sh

read -p "Enter AWS EC2 public IP address: " aws_public_ip

chmod 400 ~/Downloads/labsuser.pem
scp -i ~/Downloads/labsuser.pem setup_aws.sh ec2-user@$aws_public_ip:/home/ec2-user
scp -i ~/Downloads/labsuser.pem .env docker-compose.yml deploy.sh ec2-user@$aws_public_ip:/home/ec2-user/app
