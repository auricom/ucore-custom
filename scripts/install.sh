#!/bin/sh

set -ouex pipefail


# renovate: datasource=github-releases depName=getsops/sops
SOPS_VERSION=v3.8.1

# ensure that RPM post-install don't break with alternatives reqs
mkdir -p /var/lib/alternatives

rpm-ostree install \
    age \
    btop \
    container-tools \
    distrobox \
    fish \
    fzf \
    go-task

rpm-ostree install "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION#v}.x86_64.rpm"

if [ -x "/usr/sbin/zpool" ]; then
    rpm-ostree install \
        nfs-utils \
        samba
    /tmp/apps/zrepl.sh
fi