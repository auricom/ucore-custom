#!/usr/bin/bash

set -ouex pipefail

# renovate: datasource=github-tags depName=45Drives/cockpit-file-sharing
COCKPIT_FILE_SHARING=v4.2.6

git clone --branch "${COCKPIT_FILE_SHARING}" https://github.com/45drives/cockpit-file-sharing.git /tmp/cockpit-file-sharing

cp -r /tmp/cockpit-file-sharing/file-sharing /usr/share/cockpit
