#!/bin/bash

set -ouex pipefail

/tmp/apps/cockpit-ws-zfs.sh
/tmp/apps/zrepl.sh storage-remote storage
