#!/usr/bin/bash

set -ouex pipefail

# renovate: datasource=github-releases depName=creativeprojects/resticprofile
RESTICPROFILE_VERSION=v0.29.1


RELEASE_INFO=$(curl -s "https://api.github.com/repos/creativeprojects/resticprofile/releases/tags/${RESTICPROFILE_VERSION}")
ASSET_URL=$(echo "${RELEASE_INFO}" | grep -oP '"browser_download_url": "\K[^"]+' | grep 'linux_amd64\.tar\.gz$' | grep no_self_update )

curl -L -o "/tmp/resticprofile.tar.gz" "${ASSET_URL}"

tar -xzf /tmp/resticprofile.tar.gz -C /tmp

mv /tmp/resticprofile /usr/bin