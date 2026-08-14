#!/usr/bin/env bash

set -euo pipefail

DEVICE="/dev/nvme0n1p2"
MOUNT_POINT="/mnt/backup"
FSTAB="/etc/fstab"

# Require root
if [[ $EUID -ne 0 ]]; then
    echo "Please run as root: sudo $0"
    exit 1
fi

# Make sure the device exists
if [[ ! -b "$DEVICE" ]]; then
    echo "Error: $DEVICE does not exist."
    exit 1
fi

# Get UUID and filesystem type
UUID=$(blkid -s UUID -o value "$DEVICE")
FSTYPE=$(blkid -s TYPE -o value "$DEVICE")

if [[ -z "$UUID" ]]; then
    echo "Error: Could not determine UUID for $DEVICE"
    exit 1
fi

if [[ -z "$FSTYPE" ]]; then
    echo "Error: Could not determine filesystem type for $DEVICE"
    exit 1
fi

echo "Device:       $DEVICE"
echo "UUID:         $UUID"
echo "Filesystem:   $FSTYPE"
echo "Mount point:  $MOUNT_POINT"

# Create mount point
mkdir -p "$MOUNT_POINT"

# Don't add a duplicate entry
if grep -qE "^[[:space:]]*UUID=${UUID}[[:space:]]" "$FSTAB"; then
    echo "An fstab entry for UUID=$UUID already exists."
else
    # Back up fstab
    cp "$FSTAB" "${FSTAB}.bak"

    # Append entry
    echo "UUID=$UUID  $MOUNT_POINT  $FSTYPE  defaults  0  2" >> "$FSTAB"

    echo "Added to $FSTAB:"
    echo "UUID=$UUID  $MOUNT_POINT  $FSTYPE  defaults  0  2"
fi

sudo systemctl daemon-reload

echo
echo "Done. Reboot to mount $DEVICE at $MOUNT_POINT."
