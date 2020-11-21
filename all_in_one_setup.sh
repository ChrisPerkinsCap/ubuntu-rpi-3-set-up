#!/bin/bash

var unsername="${1}:-";

function create_new_user() {

  echo "Please enter a name for a new user:"

  read -r username

  echo "This will also create a group called ${username}"
  echo "and a home directory of /home/${username}/"

  sleep 3

  adduser "${username}"
}

function make_super_user() {
  usermod -aG sudo "${username}"
}

function disable_password_login() {

  if [ -n "${1}" ];
  then
    username="${1}";
  else
    username="ubuntu";
  fi

  echo "Match User ${username}" >> /etc/ssh/sshd_config
  echo "      PasswordAuthentication no" >> /etc/ssh/sshd_config

  echo "Login disabled for user ${username}."

  sleep 1
}

function disable_default_login() {

  disable_password_login "ubuntu";
}

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

  public_signature="$(apt-key fingerprint 0EBFCD88 | grep '0EBF CD88' | xargs)";

  correct_key=$( echo "9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88" | xargs );

  if [[ "${public_signature}" == "${correct_key}" ]]
  then
    echo "Plubic signature is a match.";
    echo "Downloaded: ${public_signature}";
    echo "Should be:  ${correct_key}";
  else
    echo "Docker inc GPG Signature doesn't match. Exiting!!!"
    echo "Downloaded: ${public_signature}";
    echo "Should be:  ${correct_key}";
    exit 1;
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

  apt-get install -y  docker-ce docker-ce-cli containerd.io

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

echo "Do you whish to create a new user?"
echo "Please enter y / n :"
read -r create_user

echo "Do you want this user to have 'root' user privileges?"
echo "Please enter y / n :"
read -r is_root

prepare_node

add_docker_secure_key

add_docker_repo

install_docker

test_docker_install

install_docker_compose

test_docker_compose

if [[ "${create_user}" == "y" ]] || [[ "${create_user}" == "Y" ]] ||
   [[ "${create_user}" == "Yes" ]] || [[ "${create_user}" == "yes" ]]
then
  create_new_user
fi

if [[ "${is_root}" == "y" ]] || [[ "${is_root}" == "Y" ]] ||
   [[ "${is_root}" == "Yes" ]] || [[ "${is_root}" == "yes" ]]
then
  make_super_user
fi

disable_default_login

echo "Rebooting! Please be patient and reconnect as your new user in a couple of minutes."

sleep 2

reboot

exit 0;