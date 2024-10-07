#!/usr/bin/bash

set -ouex pipefail


# renovate: datasource=github-releases depName=getsops/sops
SOPS_VERSION=v3.9.1
RELEASE_URL="https://api.github.com/repos/getsops/sops/releases/tags/${SOPS_VERSION}"

RPM_URL=$(curl -s "${RELEASE_URL}" | grep -oP '(?<="browser_download_url": ")[^"]*\.x86_64\.rpm')

if [[ -z "${RPM_URL}" ]]; then
    echo "No RPM found for SOPS version ${SOPS_VERSION}"
    exit 1
fi

rpm-ostree install "${RPM_URL}"