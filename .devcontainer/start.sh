#!/bin/bash
set -e

echo "======================================"
echo " Starting Xray Setup "
echo "======================================"
echo ""

echo "DEBUG ENV:"
echo "CODESPACE_NAME=$CODESPACE_NAME"
echo "PORT_DOMAIN=$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN"
echo ""

# stop previous runs
pkill -f xray || true
pkill -f keepalive || true

mkdir -p /etc/xray

# generate UUID once
if [ ! -f /etc/xray/uuid.txt ]; then
    uuidgen > /etc/xray/uuid.txt
fi

UUID=$(cat /etc/xray/uuid.txt)

echo "UUID = $UUID"
echo ""

# fallback values
if [ -z "$CODESPACE_NAME" ]; then
  CODESPACE_NAME=$(hostname)
fi

if [ -z "$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN" ]; then
  GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN="app.github.dev"
fi

HOST="${CODESPACE_NAME}-443.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

echo "HOST = $HOST"
echo ""

# generate config
sed "s/__UUID__/$UUID/g" /config.template.json
