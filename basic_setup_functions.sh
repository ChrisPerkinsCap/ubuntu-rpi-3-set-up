#!/bin/bash

function ask_create_user() {
  echo "Do you whish to create a new user?"
  echo "Please enter y / n :"
  read -r create_user
}

function ask_make_root() {
  echo "Do you want this user to have 'root' user privileges?"
  echo "Please enter y / n :"
  read -r is_root
}

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

exit 0;