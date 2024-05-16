#!/usr/bin/bash

set -ouex pipefail

# renovate: datasource=github-tags depName=45Drives/cockpit-zfs-manager
COCKPIT_ZFS_MANAGER=v1.3.1

git clone --branch ${COCKPIT_ZFS_MANAGER} https://github.com/45drives/cockpit-zfs-manager.git /tmp/cockpit-zfs-manager

cp -r /tmp/cockpit-zfs-manager/zfs /usr/share/cockpit

# https://github.com/45Drives/cockpit-zfs-manager/issues/15#issuecomment-1698850989
rpm-ostree install cockpit
mkdir -p /usr/share/cockpit/base1/fonts/
curl --silent --output /usr/share/cockpit/base1/fonts/fontawesome.woff https://github.com/h5p/font-awesome/raw/master/fontawesome-webfont.woff
curl --silent --output /usr/share/cockpit/base1/fonts/glyphicons.woff https://github.com/twbs/bootstrap-sass/raw/master/assets/fonts/bootstrap/glyphicons-halflings-regular.woff
curl --silent --output /usr/share/cockpit/base1/fonts/patternfly.woff https://github.com/patternfly/patternfly-sass/raw/master/assets/fonts/patternfly/PatternFlyIcons-webfont.woff
curl --silent --output -P /usr/share/cockpit/static/fonts/OpenSans-Semibold-webfont.woff https://github.com/braintree/braintree_slim_example/raw/main/static/fonts/open-sans/OpenSans-Semibold-webfont.woff
mkdir -p /usr/share/cockpit/zfs/assets/fonts/RedHatDisplay/
cp -v /usr/share/cockpit/static/fonts/*Display*.woff2 /usr/share/cockpit/zfs/assets/fonts/RedHatDisplay/
for f in /usr/share/cockpit/zfs/assets/fonts/RedHatDisplay/*; do mv -v -- "$f" "${f%.woff2}.woff"; done
mkdir -p /usr/share/cockpit/zfs/assets/fonts/RedHatText/
cp -v /usr/share/cockpit/static/fonts/*Text*.woff2 /usr/share/cockpit/zfs/assets/fonts/RedHatText/
for f in /usr/share/cockpit/zfs/assets/fonts/RedHatText/*; do mv -v -- "$f" "${f%.woff2}.woff"; done
