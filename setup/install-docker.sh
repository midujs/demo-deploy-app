#!/bin/bash
# Install docker
curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
docker -v

# Install docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v

# Add user to docker group
sudo usermod -aG docker $USER

# Swap file
sudo fallocate -l 4G /swapfile
sudo ls -lh /swapfile
sudo chmod 600 /swapfile
sudo ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab