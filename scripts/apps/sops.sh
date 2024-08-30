#!/usr/bin/bash

set -ouex pipefail


# renovate: datasource=github-releases depName=getsops/sops
SOPS_VERSION=v3.9.0

get_rpm_url() {
    local version=$1
    local release_url="https://api.github.com/repos/getsops/sops/releases/tags/${version}"

    rpm_url=$(curl -s "${release_url}" | grep -oP '(?<="browser_download_url": ")[^"]*\.x86_64\.rpm')

    if [[ -z "${rpm_url}" ]]; then
        echo "No RPM found for SOPS version ${version}"
        exit 1
    fi

    echo "${release_url}/${rpm_url}"
}

RPM_URL=$(get_rpm_url "${SOPS_VERSION}")

if [[ -z "${RPM_URL}" ]]; then
    echo "No RPM found for SOPS version ${SOPS_VERSION}"
    exit 1
fi

rpm-ostree install "${RPM_URL}"