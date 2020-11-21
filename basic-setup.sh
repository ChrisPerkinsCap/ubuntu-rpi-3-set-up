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

apt-get update

echo "Do you whish to create a new user?"
echo "Please enter y / n :"
read -r create_user

echo "Do you want this user to have 'root' user privileges?"
echo "Please enter y / n :"
read -r is_root

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