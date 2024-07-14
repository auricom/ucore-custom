#!/usr/bin/bash

set -ouex pipefail


# renovate: datasource=github-releases depName=getsops/sops
SOPS_VERSION=v3.8.1

get_rpm_url() {
    local version=$1
    local api_url="https://api.github.com/repos/getsops/sops/releases/tags/${version}"

    rpm_url=$(curl -s "$api_url" | jq -r '.assets[] | select(.name | endswith(".x86_64.rpm")) | .browser_download_url')

    echo "$rpm_url"
}

RPM_URL=$(get_rpm_url "$SOPS_VERSION")

if [ -z "$RPM_URL" ]; then
    echo "No RPM found for SOPS version $SOPS_VERSION"
    exit 1
fi

rpm-ostree install "$RPM_URL"