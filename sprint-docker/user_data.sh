#!/bin/bash

sudo yum update -y

sudo yum install -y docker
sudo service docker start
sudo systemctl enable docker

sudo yum install -y amazon-efs-utils

sudo mkdir -p /mnt/efs

sudo mount -t nfs -o nfsvers=4.1 fs-0cfbfc095fb55c2e3.efs.us-east-1.amazonaws.com:/ /mnt/efs

mkdir worpress
cd worpress/
touch docker-compose.yaml

file="docker-compose.yaml"
echo "services:" >> $file
echo "  wordpress:" >> $file
echo "    image: wordpress:latest" >> $file
echo "    container_name: wordpress" >> $file
echo "    ports:" >> $file
echo "      - \"80:80\"" >> $file
echo "    environment:" >> $file
echo "      WORDPRESS_DB_HOST: <end point>" >> $file
echo "      WORDPRESS_DB_USER: <usuário>" >> $file
echo "      WORDPRESS_DB_PASSWORD: <senha>" >> $file
echo "      WORDPRESS_DB_NAME: wpdatabase" >> $file
echo "    volumes:" >> $file
echo "      - /mnt/efs:/var/www/html" >> $file
echo "" >> $file
echo "volumes:" >> $file
echo "  wordpress_data:" >> $file

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo docker-compose up -d
