#!/usr/bin/env bash
#
# Wrapper around intelmas, so you don't need to remember the command-line
# details. Because how often do you really do this?
#
# Safe to run. It only prints out the commands you should use
#
# Usage:
#
#   $ ./optane-firmware-update.sh <drive-id>
#
#
# drive-id can be a path to a /dev NVME device *or* an Optane disk SN
# acquired from optane-enumerate.sh (or nvme list)
#
# - AG
#
set -eu
SUDO="${SUDO:-sudo}"

if [ $# -ne 1 ]; then
  echo "Usage:"
  printf "%s <drive-id>\n" "$(basename "$0")"
  $SUDO intelmas show -a -o json -intelssd | jq '.[]' -c | grep -v 'Drive is not an Intel SSD' | jq '.'
  exit 0
fi
echo
id="$1"

$SUDO intelmas show -intelssd $id
echo
echo "sudo intelmas load -intelssd $id"
echo "sudo intelmas load -source <somefile> -intelssd $id"
echo
exit 0
