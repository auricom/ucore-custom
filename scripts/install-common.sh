#!/bin/bash

set -ouex pipefail


# renovate: datasource=github-releases depName=getsops/sops
SOPS_VERSION=v3.8.1

# ensure that RPM post-install don't break with alternatives reqs
mkdir -p /var/lib/alternatives

rpm-ostree install \
    age \
    cockpit-system \
    cockpit-ostree \
    cockpit-podman \
    distrobox \
    fish \
    fzf

rpm-ostree install "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION#v}.x86_64.rpm"


#
# Brew
#

# https://github.com/ublue-os/bluefin/blob/c804b2deb730d5d846717957b5780a7c56825fe3/build_files/base/brew.sh

# Convince the installer we are in CI
touch /.dockerenv

# Make these so script will work
mkdir -p /var/home
mkdir -p /var/roothome

curl -Lo /tmp/brew-install https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
chmod +x /tmp/brew-install
/tmp/brew-install
tar --zstd -cvf /usr/share/homebrew.tar.zst /home/linuxbrew/.linuxbrew