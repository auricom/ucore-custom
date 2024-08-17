#!/usr/bin/bash

set -ouex pipefail

source /etc/ucore/common_utils.sh

curl -m 10 --retry 5 "https://hc-ping.com/${HEALTHCHECK_ID}/start"

result=$(rpm-ostree update)

curl -m 10 --retry 5 "https://hc-ping.com/${HEALTHCHECK_ID}/$?"

if [[ "${result}" != *"No upgrade available."* ]]; then
    /usr/sbin/reboot
fi