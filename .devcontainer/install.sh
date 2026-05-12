#!/bin/sh
set -e

XRAY_VERSION="v26.3.27"
TMP_DIR="/tmp/xray-install"
XRAY_URL="https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip"

echo "Installing Xray ${XRAY_VERSION}"

# پیش‌نیازها
command -v wget >/dev/null 2>&1 || { echo "wget not installed"; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "unzip not installed"; exit 1; }

# دایرکتوری موقت
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

echo "Downloading Xray..."
wget -q -O xray.zip "$XRAY_URL"

echo "Extracting..."
unzip -q xray.zip

echo "Installing binary..."
chmod +x xray
mv xray /usr/local/bin/xray

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "Xray installed successfully"
