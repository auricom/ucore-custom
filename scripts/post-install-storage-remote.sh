#!/bin/bash

set -ouex pipefail

# cockpit-ws
systemctl enable cockpit.service

# Wireguard
systemctl enable wg0-client.service

# ZFS
systemctl enable ucore-zfs-kernel.service
systemctl enable zrepl.service

# firwall rules
systemctl enable ucore-firewalld-setup-storage-remote.service