#!/bin/bash

set -ouex pipefail

# cockpit-ws
systemctl enable cockpit.service

# firwall rules
systemctl enable ucore-firewalld-setup-service.service
