#!/bin/bash

set -ouex pipefail


# ensure that RPM post-install don't break with alternatives reqs
mkdir -p /var/lib/alternatives

rpm-ostree install \
    age \
    cockpit-system \
    cockpit-ostree \
    cockpit-podman \
    distrobox \
    fish \
    fzf \
    usbutils

/tmp/apps/brew.sh
/tmp/apps/cockpit-zfs.sh
/tmp/apps/sops.sh


if [[ "${HOST}" = "storage" ]]; then
    rpm-ostree uninstall \
        nfs-utils-coreos

    rpm-ostree install \
        nfs-utils \
        nut \
        samba

    /tmp/apps/cockpit-file-sharing.sh
    /tmp/apps/resticprofile.sh
    /tmp/apps/zrepl.sh storage storage-remote

elif [[ "${HOST}" = "storage-remote" ]]; then

    /tmp/apps/zrepl.sh storage-remote storage

else

    echo "HOST does not match 'storage' or 'storage-remote'. No script executed."

fi