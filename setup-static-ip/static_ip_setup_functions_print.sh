#!/bin/bash

## PRINT VARIABLES ##

function print_dns_server_1() {

  if [[ -z "${dns_server_1}" ]]; then
    printf "\nDNS Server 1 is not set\n"
  elif [[ -n "${dns_server_1}" ]]; then
    printf "\nDNS Server 1: ${dns_server_1}\n"
  fi
}

function print_dns_server_2() {

  if [[ -z "${dns_server_2}" ]]; then
    printf "\nDNS Server 2 not set\n"
  elif [[ -n "${dns_server_2}" ]]; then
    printf "\nDNS Server 2: ${dns_server_2}\n"
  fi
}

function print_dns_server_list() {

  if [[ -z "${dns_server_list}" ]]; then
    printf "\nDNS Server list not set\n"
  elif [[ -n "${dns_server_list}" ]]; then
    printf "\nDNS Server list: ${dns_server_list}\n"
  fi
}

function print_gateway_interface() {

  if [[ -z "${gateway_interface}" ]]; then
    printf "\nThe Gateway Interface is not set\n"
  elif [[ -n "${gateway_interface}" ]]; then
    printf "\nNetwork Gateway Interface: ${gateway_interface}\n"
  fi
}

function print_ip_address() {

  if [[ -z "${ip_address}" ]]; then
    printf "\nIP Address not set\n"
  elif [[ -n "${ip_address}" ]]; then
    printf "\nIP Address: ${ip_address}\n"
  fi
}

function print_netmask() {

  if [[ -z "${netmask}" ]]; then
    printf "\nNetmask not set\n"
  elif [[ -n "${netmask}" ]]; then
    printf "\nNetmask: ${netmask}\n"
  fi
}

function print_net_adapter() {

  if [[ -z "${network_adapter}" ]]; then
    printf "\nThe Network Adapter is not set\n"
  elif [[ -n "${network_adapter}" ]]; then
    printf "\nNetwork Adapter: ${network_adapter}\n"
  fi
}

function print_net_conf_file() {

  if [[ -z "${network_conf_file}" ]]; then
    printf "\nThe Network Configuration is not set\n"
  elif [[ -n "${network_conf_file}" ]]; then
    printf "\nNetwork Configuration File: ${network_conf_file}\n"
  fi
}

function print_net_conf_path() {

  if [[ -z "${network_conf_path}" ]]; then
    printf "\nThe Network Configuration is not set\n"
  elif [[ -n "${network_conf_path}" ]]; then
    printf "\nNetwork Configuration Path: ${network_conf_path}\n"
  fi
}

function print_net_manager() {

  if [[ -z "${network_manager}" ]]; then
    printf "\nThe Network Manager is not set\n"
  elif [[ -n "${network_manager}" ]]; then
    printf "\nNetwork Manager: ${network_manager}\n"
  fi
}

function print_all_vars() {

  echo "         VARIABLES CURRENT VALUES"
  echo "|--------------------------------------------|"
  echo "|--------------------------------------------|"
  sleep 1

  print_dns_server_1
  sleep 1

  print_dns_server_2
  sleep 1

  print_dns_server_list
  sleep 1

  print_gateway_interface
  sleep 1

  print_ip_address
  sleep 1

  print_netmask
  sleep 1

  print_net_adapter
  sleep 1

  print_net_conf_file
  sleep 1

  print_net_conf_path
  sleep 1

  print_net_manager
  sleep 1

  echo "        END VARIABLES CURRENT VALUES"
  echo "|--------------------------------------------|"
  echo "|--------------------------------------------|"
}