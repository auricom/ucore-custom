#!/bin/bash

set -ouex pipefail

# cockpit-ws
systemctl enable cockpit.service

# ZFS
systemctl enable ucore-zfs-kernel.service
systemctl enable zrepl.service

# NFS
systemctl enable nfs-server.service

# Samba
systemctl enable smb.service

# firwall rules
systemctl enable ucore-firewalld-setup-storage.service