#!/bin/bash

set -ouex pipefail


# renovate: datasource=github-releases depName=getsops/sops
SOPS_VERSION=v3.8.1

# ensure that RPM post-install don't break with alternatives reqs
mkdir -p /var/lib/alternatives

rpm-ostree install \
    age \
    btop \
    cockpit-system \
    cockpit-ostree \
    cockpit-podman \
    distrobox \
    fish \
    fzf \
    go-task

rpm-ostree install "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION#v}.x86_64.rpm"
