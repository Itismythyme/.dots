#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Dependencies
# ============================================================

# --- Wifi ---

sudo dnf install iwlwifi-mvm-firmware

# --- Fedora Dependencies ---

sudo dnf install -y dnf-plugins-core

sudo dnf install -y \
    "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"


# --- LibreWolf ---

sudo dnf config-manager addrepo \
    --from-repofile=https://repo.librewolf.net/librewolf.repo


# ============================================================
# Applications
# ============================================================

sudo dnf install -y \
    emacs \
    fish \
    texlive-scheme-full \
    alacritty \
    librewolf

# ============================================================
# Install ffmpeg
# ============================================================
sudo dnf install -y ffmpeg ffmpeg-libs --allowerasing

# ============================================================
# Input / Output Recognition
# ============================================================

sudo dnf install -y \
    wev \
    wlr-randr


# ============================================================
# Fonts
# ============================================================

sudo dnf install -y \
    google-noto-fonts-all \
    unifont-fonts \
    fontconfig \
    google-noto-sans-cjk-fonts \
    google-noto-serif-cjk-fonts

fc-cache -f

echo "Finished."
