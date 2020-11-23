#!/bin/bash

unsername="${1}:-";
create_user="n";
is_root="1";

source ./basic-setup-functions.sh

apt-get update

ask_create_user

ask_make_root

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