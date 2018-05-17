#!/bin/bash

install_docker() {
    sudo apt-get remove docker docker-engine docker.io
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-compose

}

ubuntu_version=$(lsb_release -rs)

if [ "$ubuntu_version" != "16.04" ]; then
    >&2 echo "Error: This script only support Ubuntu 16.04"
    exit 1
fi

docker -v
docker_check=$?
docker-compose version
docker_compose_check=$?

if [ $docker_check -ne 0 ] || [ $docker_compose_check -ne 0 ]; then
    install_docker
fi

git --version
git_check=$?

if [ $git_check -ne 0 ]; then
    sudo apt-get update
    sudo apt-get install -y git
fi

if [ ! -e ".git" ]; then
    git clone https://github.com/Proscend/docker-opevpn-as.git ~/docker-pritunl
    cd ~/docker-pritunl
fi

(
cat <<EOF
version: '2'

services:
  pritunl:
    image: jippi/pritunl
    volumes:
      - pritunl:/var/lib/pritunl
      - mongo:/var/lib/mongodb
    privileged: true
    network_mode: "host"
    restart: always

volumes:
  mongo:
  pritunl:
EOF
) > docker-compose.yml

./start.sh
