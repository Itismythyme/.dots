#!/bin/bash

set -e

DEVICE="/dev/nvme0n1p2"
MOUNT_POINT="/mnt/backup"

# Get filesystem UUID
UUID=$(blkid -s UUID -o value "$DEVICE")

if [ -z "$UUID" ]; then
    echo "Could not determine UUID for $DEVICE"
    exit 1
fi

# Create mount point
mkdir -p "$MOUNT_POINT"

# Add fstab entry if it doesn't already exist
if ! grep -q "UUID=$UUID" /etc/fstab; then
    echo "UUID=$UUID $MOUNT_POINT ext4 defaults 0 2" >> /etc/fstab
fi

# Mount
mount "$MOUNT_POINT"

echo "Mounted $DEVICE at $MOUNT_POINT and configured /etc/fstab."
