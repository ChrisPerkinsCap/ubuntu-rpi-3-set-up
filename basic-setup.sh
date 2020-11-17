#!/bin/bash

apt-get update

echo "Do you whish to create a new user?"

read create_user

echo "Please enter a name for a new user:"

read username

echo "This will also create a group called '${username}"
echo "and a home directory of /home/${username}/"

sleep 3

adduser ${username}

usermod -aG sudo ${username}

echo "Match User ubuntu" >> /etc/ssh/sshd_config
echo "      PasswordAuthentication no" >> /etc/ssh/sshd_config

reboot
