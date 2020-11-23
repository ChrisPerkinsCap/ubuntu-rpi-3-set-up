#!/bin/bash

source ./docker-setup-functions.sh

prepare_node

add_docker_secure_key

add_docker_repo

install_docker

test_docker_install

install_docker_compose

test_docker_compose

exit 0;