#!/bin/bash

unsername="${1}:-";
create_user="n";
is_root="1";

source ./docker-setup-functions.sh

source ./make-new-superuser/make-superuser-functions.sh

ask_create_user

ask_make_root

apt-get update

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