#!/bin/bash

set -ouex pipefail


# cockpit-ws
systemctl enable cockpit.service

# brew
systemctl enable brew-setup.service
systemctl enable brew-upgrade.timer
systemctl enable brew-update.timer

# podman
systemctl enable podman.socket
systemctl enable netavark-firewalld-reload.service

systemctl enable ucore-update.timer

# ZFS
systemctl enable ucore-zfs-kernel.service
systemctl enable zrepl.service
systemctl enable zrepl-secrets.service

# firwall rules
systemctl enable ucore-firewalld-setup.service

if [[ "${HOST}" = "storage" ]]; then

    # NFS
    systemctl enable nfs-server.service

    # Samba
    systemctl enable smb.service

elif [[ "${HOST}" = "storage-remote" ]]; then

    # Wireguard
    systemctl enable wg0-client.service

else

    echo "HOST does not match 'storage' or 'storage-remote'. No script executed."

fi