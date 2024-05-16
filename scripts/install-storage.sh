#!/bin/bash

set -ouex pipefail

rpm-ostree install \
    nfs-utils \
    samba

/tmp/apps/cockpit-ws-zfs.sh
/tmp/apps/zrepl.sh
