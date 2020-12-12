#!/bin/bash

dns_server_1=""

dns_server_2=""

dns_server_list=""

gateway_interface=""

ip_address=""

netmask=""

network_adapter=""

network_conf_file=""

network_conf_path=""

network_interface=""

network_manager=""

## Include Files ##
source ./static_ip.env

source ./static_ip_setup_functions.sh

source ./static_ip_setup_functions_print.sh

source ./static_ip_setup_functions_netplan.sh

source ./static_ip_setup_functions_interfaces.sh

## SET UP VARIABLES ##

set_network_vars

print_all_vars

if [[ "${network_manager}" == "netplan" ]]; then
  write_netplan_config_file
elif [[ "${network_manager}" == "interfaces" ]]; then
  write_interfaces_config_file
else
  echo "Network Manager not set. Exiting";
  exit 1;
fi

exit 0;




## WRITE NETPLAN ##
