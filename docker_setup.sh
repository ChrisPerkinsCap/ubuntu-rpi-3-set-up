#!/bin/bash

function prepare_node() {

  apt-get update

  apt-get remove docker docker-engine docker.io containerd runc

  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    libffi-dev \
    libssl-dev

  sudo apt install -y python3-dev

  sudo apt-get install -y python3 python3-pip

}

function add_docker_secure_key() {

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  public_signature="$(apt-key fingerprint 0EBFCD88 | grep '0EBF CD88')";

  if [[ "${public_signature}" == "9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88" ]]
  then
    echo "Plubic signature is a match.";
    echo "Downloaded: ${public_signature}";
    echo "Should be:  9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88";
  fi
}

function  add_docker_repo_arm64() {

  add-apt-repository \
  "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
}

function  add_docker_repo_armhf() {

  add-apt-repository \
  "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
}

function  add_docker_repo_amd64() {

  add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
}

function  add_docker_repo_x86_64() {

  add_docker_repo_amd64
}

function add_docker_repo() {

  cpu_arch="$(lscpu | grep 'Architecture' | sed 's/Architecture://g' | xargs)";

  case "${cpu_arch}" in
    "aarch64")
        add_docker_repo_arm64
        ;;
    *)

  esac

  apt-get update
}

function install_docker() {

  apt-get install docker-ce docker-ce-cli containerd.io

  source ~/.profile
}

function test_docker_install() {
    sudo docker run hello-world
}

function install_docker_compose() {
    sudo pip3 install docker-compose
}

function test_docker_compose() {
    docker-compose version
}

#function add_user_to_docker() {
#  sudo usermod -aG docker "${USER}";
#
#  source ~/.profile
#}

prepare_node

add_docker_secure_key

add_docker_repo

install_docker

test_docker_install

install_docker_compose

test_docker_compose

exit 0;