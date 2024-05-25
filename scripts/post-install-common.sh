#!/bin/bash

set -ouex pipefail

# brew
systemctl enable brew-setup.service

# podman
systemctl enable podman.socket
# systemctl enable podman-auto-update.timer
systemctl enable netavark-firewalld-reload.service

systemctl enable ucore-update.service
