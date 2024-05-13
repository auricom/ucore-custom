#!/usr/bin/bash

set -ouex pipefail

# renovate: datasource=github-releases depName=zrepl/zrepl
ZREPL_VERSION=v0.6.1

RELEASE_INFO=$(curl -s "https://api.github.com/repos/zrepl/zrepl/releases/tags/${ZREPL_VERSION}")
ASSET_FILENAME=$(echo "${RELEASE_INFO}" | grep -oP '"browser_download_url": "\K[^"]+' | grep 'x86_64\.rpm$')

rpm-ostree install "${ASSET_FILENAME}"