#!/bin/bash

# Exit on any error
set -e

# Check if operation argument is provided
if [ $# -ne 1 ] || [[ ! "$1" =~ ^(backup|forget)$ ]]; then
    echo "Usage: $0 [backup|forget]"
    exit 1
fi

OPERATION=$1

# Environment variables
export PATH="/home/linuxbrew/.linuxbrew/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export SOPS_AGE_KEY_FILE="/root/.config/sops/age/keys.txt"

# Check required files
required_files=(
    "/home/linuxbrew/.linuxbrew/bin/restic"
    "/home/linuxbrew/.linuxbrew/bin/rclone"
    "/home/core/.config/rclone/rclone.conf"
    "/usr/bin/resticprofile"
    "/usr/local/share/resticprofile/profiles.yaml"
    "/usr/share/resticprofile/repository.sops.key"
    "${SOPS_AGE_KEY_FILE}"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Required file not found: $file"
        exit 1
    fi
done

# Decrypt and copy repository key
/usr/bin/sops --config /usr/share/sops/.sops.yaml exec-file \
    /usr/share/resticprofile/repository.sops.key \
    "cp {} /usr/local/share/resticprofile/key ; chmod 444 /usr/local/share/resticprofile/key"

# Decrypt and copy environment file
/usr/bin/sops --config /usr/share/sops/.sops.yaml exec-file \
    /usr/share/resticprofile/resticprofile.sops.env \
    "cp {} /usr/local/share/resticprofile/resticprofile.env ; chmod 444 /usr/local/share/resticprofile/resticprofile.env"

# Setup rclone config
mkdir -p /root/.config/rclone
if [ ! -L /root/.config/rclone/rclone.conf ]; then
    ln -s /home/core/.config/rclone/rclone.conf /root/.config/rclone/rclone.conf
fi

# Source the environment file
source /usr/local/share/resticprofile/resticprofile.env

# Set healthcheck ID based on operation
if [ "$OPERATION" = "backup" ]; then
    HEALTHCHECK_ID="${RESTICPROFILE_BACKUP_HEALTHCHECKS_ID}"
else
    HEALTHCHECK_ID="${RESTICPROFILE_FORGET_HEALTHCHECKS_ID}"
fi

# Send start ping
/usr/bin/curl --max-time 10 --retry 5 "https://hc-ping.com/${HEALTHCHECK_ID}/start"

# Run operation
/usr/bin/resticprofile --config /usr/local/share/resticprofile/profiles.yaml storage-feisar-ovh.$OPERATION

# Send completion ping
/usr/bin/curl --max-time 10 --retry 5 "https://hc-ping.com/${HEALTHCHECK_ID}"
