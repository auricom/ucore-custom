#!/usr/bin/bash

set -ouex pipefail


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