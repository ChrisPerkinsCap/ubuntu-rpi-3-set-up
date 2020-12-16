#!/bin/bash

## VARIABLE SETTERS ##

function set_network_adapter() {

  network_adapter=$(ip route get "8.8.8.8" | grep -Po '(?<=(dev )).*(?= src| proto)')

  if [[ -z "${network_adapter}" ]]; then
    echo "Network Adapter Not set"
  fi
  echo "Network Adapter: ${network_adapter}";
}

function set_network_manager() {
  if [[ -z "${network_adapter}" ]]; then
    set_network_adapter
  fi

  if [[ -z "${network_adapter}" ]]; then
    echo "Network Adapter Not set"
  fi

  is_netplan=$(whereis netplan | grep '/etc/netplan' | sed "s/[:].*//g")

  if [[ "${is_netplan}" == "netplan" ]]; then
    network_manager="netplan"
  elif [[ -z "${is_netplan}" ]]; then
    network_manager="interfaces"
  else
    printf "\n Network Manager not set";
    printf "\n Network Manager: ${network_manager}\n"
  fi
}

function set_network_conf_path() {

  if [[ "${network_manager}" == "netplan" ]] && [[ -d "/etc/netplan" ]]; then
    network_conf_path="/etc/netplan"
  elif [[ "${network_manager}" == "interfaces" ]] && [[ -d "/etc/network" ]]; then
    network_conf_path="/etc/network"
  else
    network_conf_path=""
    echo "Network Configuration Path is unset"
  fi
  echo "Network Configuration Path: ${network_conf_path}";
}

function set_network_conf_file() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
     [[ "$(ls -1 /etc/netplan/ | grep '50-cloud-init.yaml')" == "50-cloud-init.yaml" ]]; then
    network_conf_file=$(ls -1 /etc/netplan/ | grep '50-cloud-init.yaml');
  elif [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
     [[ "$(ls -1 /etc/netplan/ | grep '00-installer-config.yaml')" == "00-installer-config.yaml" ]]; then
    network_conf_file=$(ls -1 /etc/netplan/ | grep '50-cloud-init.yaml');
  elif [[ "${network_manager}" == "interfaces" ]] && [[ "${network_conf_path}" == "/etc/network" ]] &&
     [[ "$(ls -1 /etc/network/ | grep 'interfaces')" == "interfaces" ]]; then
    network_conf_file=$(ls -1 /etc/network/ | grep 'interfaces');
  else
    network_conf_file=""
    echo "Network Configuration File is unset"
  fi
  echo "Network Configuration File: ${network_conf_file}";
}

function set_dns_server_list() {

  if [[ -n "${dns_server_1}" ]] && [[ -n "${dns_server_2}" ]] && [[ "${network_manager}" == "netplan" ]]; then
    dns_server_list="${dns_server_1},${dns_server_2}";
  elif [[ -n "${dns_server_1}" ]] && [[ -n "${dns_server_2}" ]] && [[ "${network_manager}" == "interfaces" ]]; then
    dns_server_list="${dns_server_1} ${dns_server_2}";
  elif [[ -n "${dns_server_1}" ]] && [[ -z "${dns_server_2}" ]]; then
    dns_server_list="${dns_server_1}"
  elif [[ -z "${dns_server_1}" ]] && [[ -n "${dns_server_2}" ]]; then
    dns_server_list="${dns_server_2}"
  else
    echo "DNS Ser List not set due to no DNS Servers";
  fi
  echo "${dns_server_list}";
  sleep 1;
}

function set_network_vars() {

  get_all_addresses

  sleep 1;

  if [[ -z "${network_adapter}" ]]; then
    set_network_adapter
  else
    printf "\n Network Adapter not changed \n";
    printf "\n DNetwork Adapter: ${network_adapter}\n";
  fi

  sleep 1;

  if [[ -z "${network_manager}" ]]; then
    set_network_manager
  else
    printf "\n Network manager not changed \n";
    printf "\n Network manager: ${network_manager}\n";
  fi

  sleep 1;

  if [[ -z "${network_conf_path}" ]]; then
    set_network_conf_path
  else
    printf "\n Network configuration path not changed \n";
    printf "\n Network configuration path: ${network_conf_path}\n";
  fi

  sleep 1;

  if [[ -z "${network_conf_file}" ]]; then
    set_network_conf_file
  else
    printf "\n Network configuration file not changed \n";
    printf "\n Network configuration file: ${network_conf_file}\n";
  fi

  sleep 1;

  if [[  -n "${dns_server_1}" ]] && [[ -n "${dns_server_2}" ]] && [[ -z "${dns_server_list}" ]]; then
    set_dns_server_list
  elif [[  -n "${dns_server_1}" ]] || [[ -n "${dns_server_2}" ]] && [[ -z "${dns_server_list}" ]] ; then
    set_dns_server_list
  else
    printf "\n DNS server list not changed \n";
    printf "\n DNS server list: ${dns_server_list}\n";
  fi

  sleep 1;
}

## GETTERS

function get_dns_server_1() {

  read -p "Please enter the IP address to use for this servers first dns server: " dns_server_1

  printf "\nDNS Server 1: ${dns_server_1}\n\n";
}

function get_dns_server_2() {

  read -p "Please enter the IP address to use for this servers second dns server: " dns_server_2

  printf "\nDNS Server 2: ${dns_server_2}\n\n";
}

function get_gateway_interface() {

  read -p "Please enter the IP address to use as this servers gateway interface: " gateway_interface

  printf "\nGateway Interface: ${gateway_interface}\n\n";
}

function get_ip_address() {

  read -p "Please enter the IP address to use as this servers Static IP: " ip_address

  printf "\nIP Address: ${ip_address}\n\n";
}

function get_netmask() {

  echo "Please enter the IP address to use as this servers Static IP:"
  echo "Press enter for the default: 255.0.0.0"
  read netmask

  if [[ -z "${netmask}" ]]; then
    netmask="255.0.0.0"
  fi

  printf "\nNetmask: ${netmask}\n\n"
}

function get_all_addresses() {

  if [[ -z "${dns_server_1}" ]]; then
    get_dns_server_1
  else
    printf "\n DNS Server 1 not changed \n";
    printf "\n DNS Server 1: ${dns_server_1}\n";
  fi

  sleep 1;

  if [[ -z "${dns_server_2}" ]]; then
    get_dns_server_2
  else
    printf "\n DNS Server 2 not changed \n";
    printf "\n DNS Server 2: ${dns_server_2}\n";
  fi

  sleep 1;

  if [[ -z "${gateway_interface}" ]]; then
    get_gateway_interface
  else
    printf "\n Gateway Interface not changed \n";
    printf "\n Gateway Interface: ${gateway_interface}\n";
  fi

  sleep 1;

  if [[ -z "${ip_address}" ]]; then
    get_ip_address
  else
    printf "\n IP address not changed \n";
    printf "\n IP address: ${ip_address}\n";
  fi

  sleep 1;

  if [[ -z "${netmask}" ]]; then
    get_netmask
  else
    printf "\n Netmask not changed \n";
    printf "\n Netmask: ${netmask}\n";
  fi

  sleep 1;
}
