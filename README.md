# ucore-custom

## Generate ignition file

1. Edit the appropriate `{{ server_name }}.bu` butane file [(Reference)](https://coreos.github.io/butane/getting-started/).

2. Generate the ignition file from the butane file.
```bash
task ignition -- {{ server_name }}
```

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
sudo mkdir -p /root/.config/sops/age
sudo nano /root/.config/sops/age/keys.txt
```

2. Change core password

```bash
sudo passwd core
```

3. Deploy [dotfiles](https://github.com/auricom/dotfiles/tree/main)
