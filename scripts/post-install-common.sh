#!/bin/bash

set -ouex pipefail

# podman services
systemctl enable podman.socket
systemctl enable podman-auto-update.timer
systemctl enable netavark-firewalld-reload.service
