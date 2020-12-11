#!/bin/bash

## WRITE NETPLAN ##

function write_netplan_remove_lines() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]]; then
    sed -i '/version: 2/d' "${network_conf_path}/${network_conf_file}"
    sed -i '/optional: true/d' "${network_conf_path}/${network_conf_file}"
    echo "Removed the following lines from the Netplan Configuration File:"
    echo "                      version: 2"
    echo "                      optional: true"
  else
    echo "Netplan config file: No lines removed."
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_netplan_version() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]]; then
    sed -i '/ethernets:/i \    version: 2' "${network_conf_path}/${network_conf_file}"
    echo "Netplan is now set to version: 2"
  else
    echo "Netplan version not set"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_netplan_renderer() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]]; then
    sed -i '/version: 2/a \    renderer: networkd' "${network_conf_path}/${network_conf_file}"
    echo "Netplan renderer is now set to networkd"
  else
    echo "Netplan renderer not set"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_netplan_turn_off_dhcp4() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]]; then
    sed -i 's/dhcp4: true/dhcp4: false/i' "${network_conf_path}/${network_conf_file}"
    echo "Netplan dhcp4 is now switched off"
  else
    echo "Netplan config dhcp4 not turned off"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_netplan_static_ip() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]] && [[ -n "${ip_address}" ]]; then
    echo "            addresses: [${ip_address}/24]" >>"${network_conf_path}/${network_conf_file}"
    echo "Netplan has set the following address as a static IP: ${ip_address}"
  else
    echo "Netplan config file static IP address not written"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_netplan_gateway_ip() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]] && [[ -n "${gateway_interface}" ]]; then
    echo "            gateway4: ${gateway_interface}" >>"${network_conf_path}/${network_conf_file}"
    echo "Netplan is now using the following address as it's gateway: ${gateway_interface}"
  else
    echo "Netplan config file gateway IP address not written"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_netplan_dns_servers() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]] && [[ -n "${dns_server_list}" ]]; then
    echo "            nameservers:" >>"${network_conf_path}/${network_conf_file}"
    echo "                addresses: [${dns_server_1},${dns_server_2}] " >>"${network_conf_path}/${network_conf_file}"
    echo "Neplan DNS Server(s) set to: ${dns_server_list}"
  else
    echo "Netplan config file dns server addresses have not been written"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
    echo "Network DNS Server 1: ${dns_server_1}"
    echo "Network DNS server 2: ${dns_server_2}"
  fi
  sleep 2
}

function write_netplan_net_adapter() {

  if [[ "${network_manager}" == "netplan" ]] && [[ "${network_conf_path}" == "/etc/netplan" ]] &&
    [[ -n "${network_conf_file}" ]] && [[ -n "${network_adapter}" ]]; then

    current_adapter=$(sed -n '/ethernets:/{n;p;}' "${network_conf_path}/${network_conf_file}" | sed 's/://' | xargs);

    if [[ "${network_adapter}" != "${current_adapter}" ]]; then
      sed -i "/${current_adapter}/d" "${network_conf_path}/${network_conf_file}"
      sed -i "/dhcp4:/i \        ${network_adapter}:" "${network_conf_path}/${network_conf_file}"
    fi
    echo "Netplan network adapter is now set"
  else
    echo "Netplan network adapter is not set"
    echo "Network Manager: ${network_manager}"
    echo "Network Configuration Path: ${network_conf_path}"
    echo "Network Configuration File: ${network_conf_file}"
  fi
  sleep 2
}

function write_netplan_config_file() {
  echo "writing Netplan Configuration File"

  write_netplan_remove_lines

  write_netplan_version

  write_netplan_renderer

  write_netplan_turn_off_dhcp4

  write_netplan_static_ip

  write_netplan_gateway_ip

  write_netplan_dns_servers

  write_netplan_net_adapter

  echo "Netplan configuration has successfully been written to: ${network_conf_path}/${network_conf_file}"

  sleep 1

  netplan apply
}