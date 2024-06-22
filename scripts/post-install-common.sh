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
# systemctl enable podman-auto-update.timer
systemctl enable netavark-firewalld-reload.service

systemctl enable ucore-update.timer
