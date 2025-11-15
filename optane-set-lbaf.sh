#!/usr/bin/env bash
#
# Print the command required to the the LBAF
#
# - AG
#
set -eu
SUDO="${SUDO:-sudo}"
dev_or_sn="$1"
# Should be an integer, obtained from optane-list-lbaf.sh
lbaf="$2"
if [ -e "$dev_or_sn" ]; then
  echo
  echo "Using nvme:"
  echo "  $SUDO nvme format --lbaf=$lbaf --timeout=3600000 $dev_or_sn"
fi
echo
echo "Using intelmas:"
echo "  $SUDO intelmas start -intelssd $dev_or_sn -nvmeformat LBAFormat=$lbaf"
echo
