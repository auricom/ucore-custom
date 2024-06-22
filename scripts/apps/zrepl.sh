#!/usr/bin/bash

set -ouex pipefail

if [[ "$#" -ne 2 ]]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 arg1 arg2"
    exit 1
fi

HOSTNAME=$1
REMOTE_HOSTNAME=$2

# renovate: datasource=github-releases depName=zrepl/zrepl
ZREPL_VERSION=v0.6.1


echo "HOSTNAME 1: ${HOSTNAME}"
echo "REMOTE_HOSTNAME 2: ${REMOTE_HOSTNAME}"

RELEASE_INFO=$(curl -s "https://api.github.com/repos/zrepl/zrepl/releases/tags/${ZREPL_VERSION}")
ASSET_FILENAME=$(echo "${RELEASE_INFO}" | grep -oP '"browser_download_url": "\K[^"]+' | grep 'x86_64\.rpm$')

rpm-ostree install "${ASSET_FILENAME}"


mkdir -p /etc/zrepl
mkdir -p /usr/share/zrepl

cp "/tmp/apps/zrepl/${HOSTNAME}.yml" /etc/zrepl/zrepl.yml
cp "/tmp/apps/zrepl/${HOSTNAME}.sops.crt" "/usr/share/zrepl/${HOSTNAME}.sops.crt"
cp "/tmp/apps/zrepl/${HOSTNAME}.sops.key" "/usr/share/zrepl/${HOSTNAME}.sops.key"
cp "/tmp/apps/zrepl/${REMOTE_HOSTNAME}.sops.crt" "/usr/share/zrepl/${REMOTE_HOSTNAME}.sops.crt"

sed -i "s@__HOSTNAME__@${HOSTNAME}@g" /etc/zrepl/zrepl.yml
sed -i "s@__REMOTE_HOSTNAME__@${REMOTE_HOSTNAME}@g" /etc/zrepl/zrepl.yml
sed -i "s@__HOSTNAME__@${HOSTNAME}@g" /etc/systemd/system/zrepl-secrets.service
sed -i "s@__REMOTE_HOSTNAME__@${REMOTE_HOSTNAME}@g" /etc/systemd/system/zrepl-secrets.service

# Modify zrepl unit service file to add secrets dependencies
sed -i '/^\[Unit\]/a After=zrepl-secrets.service' /usr/lib/systemd/system/zrepl.service