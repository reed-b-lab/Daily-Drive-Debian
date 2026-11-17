# Daily-Drive-Debian
Automated Debian post-install script for a minimal GNOME workstation with KVM/libvirt virtualization and UFW firewall rules.

# Debian Workstation & KVM Lab Setup

An automated post-install Bash script for turning a minimal Debian installation into a bloat-free GNOME daily driver and KVM/libvirt virtualization workstation.

## What It Does

* **System & CLI Essentials:** Updates the system and installs core utilities (`sudo`, `openssh-server`, `ufw`, `htop`, `curl`, `wget`, `git`, `vim`, `tmux`).
* **User Provisioning:** Creates a standard user account (if it doesn't already exist) and adds it to the `sudo`, `libvirt`, and `kvm` groups.
* **KVM / Libvirt Virtualization:** Installs `qemu-kvm`, `libvirt`, `virt-manager`, `bridge-utils`, and `ovmf` (UEFI support) and enables the `libvirtd` daemon.
* **Minimal GNOME Desktop:** Installs `gnome-core` alongside essential daily-driver apps (`firefox-esr`, `keepassxc`, `libreoffice-writer`, `libreoffice-calc`, `vlc`, `gnome-calculator`, `gnome-text-editor`, and `gnome-disk-utility`) without default desktop bloat.
* **Host Firewall (UFW):** Configures a default-deny incoming policy, restricts SSH (port `22`) to your local management subnet, and allows NAT/routed networking on `virbr0` for VMs.

## Prerequisites

* A fresh minimal installation of **Debian** (tested on Debian 12/13).
* Root access (`su -` or `sudo`).
* An active internet connection.

## Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/reed-b-lab/Daily-Drive-Debian.git
   cd Daily-Drive-Debian
   ```

2. **Configure your variables:**
   Open `setup.sh` and update `user` and `lab_subnet` at the top of the file to match your username and local network:
   ```bash
   user="yourname"
   lab_subnet="192.168.1.0/24"
   ```

3. **Run the script as root:**
   ```bash
   chmod +x setup.sh
   sudo ./setup.sh
   ```

4. **Set your user password and reboot:**
   ```bash
   passwd <yourname>
   reboot
   ```

## License

This project is open source and available under the [MIT License](LICENSE).
