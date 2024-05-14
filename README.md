# ucore-custom

## Installing the OS

1. Download the latest ISO image from the [download page](https://fedoraproject.org/coreos/download/?stream=stable#baremetal)

2. Burn the ISO to disk and boot it on the target system.

3. Run the installer

```bash
sudo coreos-installer install /dev/nvme0n1 \
    --ignition-url https://raw.githubusercontent.com/auricom/ucore-custom/main/butane/service/config.ign
```

4. Reboot, and wait for the rebases automatic reboots

## Bootstrap

1. Deploy ucore age key

```bash
mkdir -p /root/.config/sops/age
nano /root/.config/sops/age/keys.txt
```