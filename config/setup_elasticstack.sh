#!/bin/bash -x

sudo apt-get update -qq
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -qq
sudo apt-get install -y docker-ce docker-compose

sudo systemctl daemon-reload
sudo systemctl enable docker
sudo systemctl start docker

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

sudo mkdir -p /tmp/elasticstack/
sudo cp /tmp/docker-compose.yml /tmp/elasticstack/
sudo mkdir -p /tmp/elasticstack/volume/beat
sudo cp /tmp/sample-pipeline.conf /tmp/elasticstack/volume/beat/
sudo mkdir -p /tmp/elasticstack/volume/filebeat
sudo cp /tmp/filebeat.yml /tmp/elasticstack/volume/filebeat/
sudo touch /tmp/elasticstack/volume/logstash.log
cd /tmp/elasticstack/ && sudo docker-compose up -d

