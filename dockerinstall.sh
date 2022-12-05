#!/bin/bash
sudo apt-get update
sudo apt install docker.io -y
sudo snap install docker
docker --version
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
