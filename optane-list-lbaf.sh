#!/usr/bin/env bash
#
# Get list of supported LBAF for any NVME drive
# Nothing special, but easier than remembering since you'll only do
# this a dozen times in your life ...
#
# - AG
#
set -eu
SUDO="${SUDO:-sudo}"

if [ $# -ne 1 ]; then
  echo "Usage:"
  printf "  %s </dev/nvmeXnY\n"
  exit 0
fi

drive="$1"

if [ ! -e "$drive" ]; then
  echo "Device $drive does not exist, exiting ..."
  exit 1
fi

if ! echo $drive | grep -E 'n[0-9]$'; then
  echo "Please include the namespace of the device path"
  echo "  (Did you mean to specify ${drive}n1 ??)"
  exit 2
fi

# Filter out LBAF rows that have a non-zero metadata size - these are
# either unnecessary or aren't truly supported anyway
$SUDO nvme id-ns -H "$1" | grep -E '^LBA Format.*Metadata Size: 0'
