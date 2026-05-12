#!/bin/bash
set -e

echo "======================================"
echo " Starting Xray Setup "
echo "======================================"

# Kill any running instances (ignore errors)
pkill -f xray || true
pkill -f "curl -k" || true

# Generate UUID once
if [ ! -f /etc/xray/uuid.txt ]; then
    uuidgen > /etc/xray/uuid.txt
fi

UUID=$(cat /etc/xray/uuid.txt)

# Build config from template
sed "s/__UUID__/$UUID/g" /config.template.json > /etc/xray/config.json

echo ""
echo "Generated UUID:"
echo "$UUID"

# Start Xray (background)
nohup xray -config /etc/xray/config.json > /tmp/xray.log 2>&1 &

sleep 3

# Keep Codespace alive by sending local requests repeatedly
nohup bash -c '
while true; do
    curl -k -s https://127.0.0.1:443 >/dev/null 2>&1 || true
    sleep 60
done
' >/tmp/keepalive.log 2>&1 &

# Build Codespace hostname for VLESS link
CODESPACE_HOST="${CODESPACE_NAME}-443.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

# Construct VLESS link with correct parameters (security=none)
VLESS_LINK="vless://${UUID}@${CODESPACE_HOST}:443?encryption=none&security=none&type=xhttp&path=%2F#codespace-xray"

echo ""
echo "======================================"
echo " XRAY READY "
echo "======================================"
echo ""

echo "UUID:"
echo "$UUID"
echo ""

echo "VLESS LINK:"
echo "$VLESS_LINK"
echo ""

echo "IMPORTANT:"
echo "You MUST make port 443 PUBLIC in the Codespaces Ports panel before use."
echo ""
echo "Open this URL: https://github.com/codespaces"
echo "Go to your Codespace → Ports → 443 → Change Visibility to Public"
echo ""

echo "======================================"
echo " Logs: "
echo "/tmp/xray.log  for Xray output"
echo "/tmp/keepalive.log  for keep-alive loop"
echo ""

if pgrep -f xray > /dev/null; then
    echo "Xray is RUNNING"
else
    echo "Xray FAILED to start. Check logs above."
fi

echo "======================================"
