#!/bin/bash

set -ouex pipefail

# ZFS
systemctl enable ucore-zfs-kernel.service
systemctl enable zrepl.service
systemctl enable zrepl-secrets.service

# NFS
systemctl enable nfs-server.service

# Samba
systemctl enable smb.service

# firwall rules
systemctl enable ucore-firewalld-setup-storage.service