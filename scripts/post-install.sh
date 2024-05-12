#!/bin/sh

set -ouex pipefail

# pre-enabled services
# systemctl enable cockpit.service
# systemctl enable node-exporter.service
# systemctl enable podman.socket
# systemctl enable podman-exporter.service

if [ -x "/usr/sbin/zpool" ]; then
	# ZFS
	echo zfs >/etc/modules-load.d/zfs.conf
	systemctl enable zrepl.service

	# NFS
	# firewall-cmd --permanent --zone=FedoraServer --add-service=nfs
	# firewall-cmd --permanent --zone=FedoraServer --add-service=rpc-bind
	# firewall-cmd --permanent --zone=FedoraServer --add-service=mountd
	systemctl enable nfs-server.service

	# Samba
	# firewall-cmd --permanent --zone=FedoraServer --add-service=samba
	systemctl enable smb.service

	# Firewall / SELinux
	restorecon -R /mnt/vol1
	# firewall-cmd --reload
	semanage fcontext --add --type "public_content_rw_t" "/mnt/vol1(/.*)?"
fi
