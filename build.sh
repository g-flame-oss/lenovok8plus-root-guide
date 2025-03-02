#!/bin/bash
set -euo pipefail

# This script is designed for Ubuntu 24 on AMD64 systems.
# It downloads Android Image Kitchen (AIK) and recovery images,
# processes the stock recovery and TWRP recovery images, and repacks a new TWRP image.
# Usage: chmod +x port_twrp.sh && ./port_twrp.sh

# ANSI color codes for output
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
NC="\e[0m"  # No Color

# Masked swear words for extra flair
mask_fuck="f*u*c*k"
mask_shit="s*h*i*t"

# Utility functions for colored output
info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# Verify the system is AMD64
ARCH=$(uname -m)
if [ "$ARCH" != "x86_64" ]; then
    error "This script is designed for AMD64 (x86_64) systems. Detected architecture: $ARCH. Exiting."
    exit 1
fi

# Check required dependencies
for cmd in wget unzip file git clang make; do
    if ! command -v "$cmd" &>/dev/null; then
        error "Command '$cmd' not found. Please install it with: sudo apt update && sudo apt install -y $cmd"
        exit 1
    fi
done

info "All dependencies are installed on AMD64. Let's get this ${mask_fuck} party started!"

# Create and switch to the working directory
WORKDIR="$(pwd)/twrp_port"
info "Creating work directory: ${WORKDIR} (${mask_shit} magic ahead)!"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

#############################
# Download and Extract AIK
#############################
AIK_ZIP="master.zip"
AIK_URL="https://github.com/ndrancs/AIK-Linux-x32-x64/archive/refs/heads/master.zip"

if [ ! -f "$AIK_ZIP" ]; then
    info "Downloading Android Image Kitchen zip (${mask_fuck} download in progress)..."
    wget -O "$AIK_ZIP" "$AIK_URL"
    success "Downloaded AIK zip."
else
    info "AIK zip already exists. Skipping download."
fi

# Extract the AIK zip into a base directory and then make two copies for processing
BASE_AIK_DIR="aik_base"
rm -rf "$BASE_AIK_DIR"
info "Extracting AIK zip into base directory (${mask_shit} extraction underway)..."
unzip -q "$AIK_ZIP" -d "$BASE_AIK_DIR"

# Find the extracted folder (should be one directory inside aik_base)
BASE_DIR=$(find "$BASE_AIK_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)
if [ -z "$BASE_DIR" ]; then
    error "Failed to detect the extracted AIK directory. Exiting."
    exit 1
fi

# Create separate directories for stock and TWRP processing
AIK_STOCK="aik_stock"
AIK_TWRP="aik_twrp"
rm -rf "$AIK_STOCK" "$AIK_TWRP"
cp -r "$BASE_DIR" "$AIK_STOCK"
cp -r "$BASE_DIR" "$AIK_TWRP"
success "Created separate AIK directories for stock and TWRP porting."

#############################
# Download Recovery Images
#############################
# Stock recovery image
STOCK_RECOVERY="$WORKDIR/stock_recovery.img"
STOCK_URL="https://github.com/g-flame-oss/Docker-Projects/raw/refs/heads/main/recovery.img"
if [ ! -f "$STOCK_RECOVERY" ]; then
    info "Downloading stock recovery image (${mask_fuck} coming right up)..."
    wget -O "$STOCK_RECOVERY" "$STOCK_URL"
    success "Stock recovery image downloaded."
else
    info "Stock recovery image already exists."
fi

# TWRP recovery image
TWRP_RECOVERY="$WORKDIR/twrp_recovery.img"
TWRP_URL="https://dl.twrp.me/manning/twrp-3.5.0_9-0-manning.img"
if [ ! -f "$TWRP_RECOVERY" ]; then
    info "Downloading TWRP recovery image (${mask_shit} hold on tight)..."
    wget -O "$TWRP_RECOVERY" "$TWRP_URL"
    success "TWRP recovery image downloaded."
else
    info "TWRP recovery image already exists."
fi

#############################
# Process Stock Recovery
#############################
info "Processing stock recovery in ${AIK_STOCK} (${mask_fuck} time to unpack)!"
cd "$WORKDIR/$AIK_STOCK"

# Ensure AIK scripts are executable
chmod +x unpackimg.sh repackimg.sh

# Copy the stock recovery image to the current directory as recovery.img
cp "$STOCK_RECOVERY" recovery.img
info "Unpacking stock recovery image (${mask_shit} magic in progress)..."
./unpackimg.sh recovery.img

# Verify that the required directories exist
if [ ! -d "ramdisk" ] || [ ! -d "split_img" ]; then
    error "Unpacking stock recovery failed: 'ramdisk' or 'split_img' directory missing."
    exit 1
fi

# Backup the stock ramdisk and split_img for later use
info "Backing up stock ramdisk and split_img (${mask_fuck} keeping it safe)!"
cd "$WORKDIR"
rm -rf stock_ramdisk stock_split_img
cp -r "$WORKDIR/$AIK_STOCK/ramdisk" stock_ramdisk
cp -r "$WORKDIR/$AIK_STOCK/split_img" stock_split_img
success "Stock recovery files backed up."

#############################
# Process TWRP (Port) Recovery
#############################
info "Processing TWRP port recovery in ${AIK_TWRP} (${mask_shit} here we go)!"
cd "$WORKDIR/$AIK_TWRP"

# Ensure AIK scripts are executable
chmod +x unpackimg.sh repackimg.sh

# Copy the TWRP recovery image as recovery.img for AIK scripts
cp "$TWRP_RECOVERY" recovery.img
info "Unpacking TWRP recovery image (${mask_fuck} unwrapping it)!"
./unpackimg.sh recovery.img

# Verify that the required directories exist
if [ ! -d "ramdisk" ] || [ ! -d "split_img" ]; then
    error "Unpacking TWRP recovery failed: 'ramdisk' or 'split_img' directory missing."
    exit 1
fi

# Replace the TWRP split_img with the stock split_img backup
info "Replacing TWRP split_img with stock version (${mask_shit} wiping and copying)..."
rm -rf split_img/*
cp -r "$WORKDIR/stock_split_img/"* split_img/
success "split_img replaced."

# Update the TWRP ramdisk by removing unwanted files and copying in the stock versions
info "Cleaning up TWRP ramdisk (${mask_fuck} updating critical files)..."
rm -f ramdisk/default.prop
rm -f ramdisk/fstab* 2>/dev/null
rm -f ramdisk/ueventd*.rc 2>/dev/null

info "Copying default.prop, fstab, and ueventd files from stock (${mask_shit} ensuring consistency)..."
cp "$WORKDIR/stock_ramdisk/default.prop" ramdisk/ 2>/dev/null || true
cp "$WORKDIR/stock_ramdisk/fstab"* ramdisk/ 2>/dev/null || true
cp "$WORKDIR/stock_ramdisk/ueventd"* ramdisk/ 2>/dev/null || true

# Copy recovery.fstab from stock's ramdisk/etc to TWRP's ramdisk/etc (if available)
if [ -f "$WORKDIR/stock_ramdisk/etc/recovery.fstab" ]; then
    info "Copying recovery.fstab from stock (${mask_fuck} crucial step)..."
    cp "$WORKDIR/stock_ramdisk/etc/recovery.fstab" ramdisk/etc/
else
    info "Stock recovery.fstab not found; skipping its copy."
fi

# Modify twrp.fstab in TWRP ramdisk/etc if it exists
if [ -f "ramdisk/etc/twrp.fstab" ]; then
    info "Modifying twrp.fstab (${mask_shit} updating mount points)..."
    sed -i 's/\/sdcard/\/external_sd/g' ramdisk/etc/twrp.fstab
    sed -i 's/\/usb/\/usb-otg/g' ramdisk/etc/twrp.fstab
fi

# Update default.prop settings in TWRP ramdisk
info "Editing default.prop (${mask_fuck} tuning system parameters)..."
DEFAULT_PROP="ramdisk/default.prop"
if [ -f "$DEFAULT_PROP" ]; then
    sed -i 's/^ro.secure=.*/ro.secure=0/' "$DEFAULT_PROP" || echo "ro.secure=0" >> "$DEFAULT_PROP"
    sed -i 's/^ro.adb.secure=.*/ro.adb.secure=0/' "$DEFAULT_PROP" || echo "ro.adb.secure=0" >> "$DEFAULT_PROP"
    sed -i 's/^security.perf_harden=.*/security.perf_harden=0/' "$DEFAULT_PROP" || echo "security.perf_harden=0" >> "$DEFAULT_PROP"
    sed -i 's/^ro.debuggable=.*/ro.debuggable=1/' "$DEFAULT_PROP" || echo "ro.debuggable=1" >> "$DEFAULT_PROP"
    sed -i 's/^persist.sys.usb.config=.*/persist.sys.usb.config=adb,mtp/' "$DEFAULT_PROP" || echo "persist.sys.usb.config=adb,mtp" >> "$DEFAULT_PROP"
else
    error "default.prop not found in TWRP ramdisk. Exiting."
    exit 1
fi

# Repack the modified TWRP recovery image
info "Repacking the new TWRP image (${mask_shit} finalizing masterpiece)..."
./repackimg.sh

if [ -f "image-new.img" ]; then
    success "Porting complete! New image is: ${WORKDIR}/${AIK_TWRP}/image-new.img"
else
    error "Repacking failed. image-new.img not found."
    exit 1
fi
EOF
