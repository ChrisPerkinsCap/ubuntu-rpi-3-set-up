#!/bin/bash

## WRITE Interfaces ##

function write_interfaces_set_static() {

  if [[ "${network_manager}" == "interfaces" ]] && [[ "${network_conf_path}" == "/etc/network" ]] &&
    [[ -n "${network_conf_file}" ]]; then
    sed -i 's/inet dhcp/inet static/i' "${network_conf_path}/${network_conf_file}";
    echo "Network interfaces is now set to static"
  else
    echo "Network interfaces has not been set and remains dhcp"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_interfaces_set_ip() {

  if [[ "${network_manager}" == "interfaces" ]] && [[ "${network_conf_path}" == "/etc/network" ]] &&
    [[ -n "${network_conf_file}" ]] && [[ -n "${ip_address}" ]]; then
    echo "        address ${ip_address}" >> "${network_conf_path}/${network_conf_file}";
    echo "Network interfaces ip is now set to ${ip_address}"
  else
    echo "Network interfaces ip has not been set"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_interfaces_set_netmask() {

  if [[ "${network_manager}" == "interfaces" ]] && [[ "${network_conf_path}" == "/etc/network" ]] &&
    [[ -n "${network_conf_file}" ]]; then
    echo "        netmask ${netmask}" >> "${network_conf_path}/${network_conf_file}";
    echo "Network interfaces netmask is now set to ${netmask}"
  else
    echo "Network interfaces netmask has not been set"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_interfaces_set_gateway() {

  if [[ "${network_manager}" == "interfaces" ]] && [[ "${network_conf_path}" == "/etc/network" ]] &&
    [[ -n "${network_conf_file}" ]] && [[ -n "${gateway_interface}" ]]; then
    echo "        gateway ${gateway_interface}" >> "${network_conf_path}/${network_conf_file}";
    echo "Network interfaces gateway is now set to ${gateway_interface}"
  else
    echo "Network interfaces gateway has not been set"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_interfaces_set_nameservers() {

  if [[ "${network_manager}" == "interfaces" ]] && [[ "${network_conf_path}" == "/etc/network" ]] &&
    [[ -n "${network_conf_file}" ]] && [[ -n "${dns_server_list}" ]]; then
    echo "        dns-nameservers ${dns_server_list}" >> "${network_conf_path}/${network_conf_file}";
    echo "Network interfaces nameservers are now set to ${dns_server_list}"
  else
    echo "Network interfaces nameservers has not been set"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_interfaces_config_file() {
  write_interfaces_set_static
  write_interfaces_set_ip
  write_interfaces_set_netmask
  write_interfaces_set_gateway
  write_interfaces_set_nameservers
  #ip a flush enp0s3
  #systemctl restart networking.service
}