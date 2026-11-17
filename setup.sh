#!/bin/bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# --- Configuration ---
user="yourname"
lab_subnet="192.168.1.0/24"  # Adjust to your local LAN/management subnet

# --- Preflight Checks ---
if [[ $EUID -ne 0 ]]; then
  echo "Error: Run this script as root." >&2
  exit 1
fi

if [[ "$user" == "yourname" ]]; then
  echo "Error: Edit the 'user' and 'lab_subnet' variables before running." >&2
  exit 1
fi

# --- System Update ---
apt update && apt full-upgrade -y

# --- Base Utilities & SSH ---
apt install -y sudo openssh-server ufw htop curl wget git vim tmux

# --- User Setup ---
if ! id "$user" &>/dev/null; then
  adduser --disabled-password --gecos "" "$user"
fi
usermod -aG sudo "$user"

# --- Virtualization (KVM / Libvirt) ---
apt install -y qemu-kvm libvirt-daemon-system libvirt-clients \
  bridge-utils virt-manager ovmf
usermod -aG libvirt,kvm "$user"
systemctl enable --now libvirtd

# --- Desktop & Apps ---
apt install -y gnome-core network-manager keepassxc firefox-esr \
  gnome-calculator gnome-text-editor libreoffice-writer \
  libreoffice-calc gnome-disk-utility vlc
 
# --- Firewall (UFW) ---
ufw default deny incoming
ufw default allow outgoing
ufw allow in on virbr0
ufw route allow in on virbr0
ufw allow from "$lab_subnet" to any port 22 proto tcp
ufw --force enable

echo "Setup complete. Set a password for $user by running: passwd $user" 
