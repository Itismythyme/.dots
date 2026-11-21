#!/usr/bin/env bash
set -euo pipefail

sudo dnf install --nogpgcheck \
    --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' \
    terra-release

sudo dnf install -y mangowm

echo "Finished."
