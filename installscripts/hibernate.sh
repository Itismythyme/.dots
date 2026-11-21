#!/usr/bin/env bash
set -euo pipefail

# Calculate swap size (RAM-based formula)
SWAPSIZE=$(free | awk '/Mem/ {x=$2/1024/1024; printf "%.0fG", (x<2 ? 2*x : x<8 ? 1.5*x : x) }')
SWAPFILE=/var/swap/swapfile

# Create btrfs subvolume and swap file
sudo btrfs subvolume create /var/swap
sudo btrfs filesystem mkswapfile --size $SWAPSIZE --uuid clear $SWAPFILE

# Enable swap file
echo $SWAPFILE none swap defaults 0 0 | sudo tee --append /etc/fstab
sudo swapon --all --verbose

# Configure dracut for resume
echo 'add_dracutmodules+=" resume "' | sudo tee /etc/dracut.conf.d/resume.conf
sudo dracut --force --verbose

# Fix SELinux permissions (critical!)
sudo semanage fcontext --add --type swapfile_t $SWAPFILE
sudo restorecon -RF /var/swap

echo "Finished."
