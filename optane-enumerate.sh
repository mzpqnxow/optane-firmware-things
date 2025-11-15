#!/usr/bin/env bash
#
# Hacky script to print a list of the Optane NVME drives, since
# inconsistent naming and OEM drives make nvme list | grep -i optane
# not useful
#
# Safe to run, won't do anything to the disks
# Usage:
#
#   $ ./optane-enumerate.sh
#
# - AG
#
set -eu
SUDO="${SUDO:-sudo}"


#
# Enumerate the Optane devices on a system without using
# a fixed set of patterns to match all of the inconsistent
# names (which don't always contain Optane or even Intel)
#
# Use:
#
#   for dev in $(optane_enum); do
#     echo do stuff with this device: $dev
#   done
#
optane_enum() {
  devs=""
  for dev in $(sudo find /dev/ -maxdepth 1 -name 'nvme[0-9]*' -type c); do
    sudo nvme intel market-name $dev >/dev/null 2>&1 || continue
    devs="$dev $devs"
  done
  echo $devs
}

# This is sufficient to get all the good info (SN, name, FW version, device name, etc.)
patt="$(optane_enum | tr ' ' '|')"
sudo nvme list | grep -E "$patt"
