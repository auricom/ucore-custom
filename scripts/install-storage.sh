#!/bin/bash

set -ouex pipefail

rpm-ostree install \
    nfs-utils \
    samba

/tmp/apps/zrepl.sh
