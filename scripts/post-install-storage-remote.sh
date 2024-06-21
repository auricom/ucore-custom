#!/bin/bash

set -ouex pipefail

# Wireguard
systemctl enable wg0-client.service

# ZFS
systemctl enable ucore-zfs-kernel.service
systemctl enable zrepl.service

# firwall rules
systemctl enable ucore-firewalld-setup-storage-remote.service