#!/bin/bash
set -e

echo "======================================"
echo " Starting Xray Setup "
echo "======================================"

# Stop old processes if running
pkill -f xray || true
pkill -f "curl -k" || true

# Create UUID only once
if [ ! -f /etc/xray/uuid.txt ]; then
    uuidgen > /etc/xray/uuid.txt
fi

UUID=$(cat /etc/xray/uuid.txt)

# Generate config from template
sed "s/__UUID__/$UUID/g" /config.template.json > /etc/xray/config.json

echo ""
echo "Generated UUID:"
echo "$UUID"

# Start Xray
nohup xray -config /etc/xray/config.json > /tmp/xray.log 2>&1 &

sleep 3

# Keep Codespace alive with local traffic
nohup bash -c '
while true; do
    curl -k -s https://127.0.0.1:443 >/dev/null 2>&1 || true
    sleep 60
done
' >/tmp/keepalive.log 2>&1 &

# Build Codespace hostname
CODESPACE_HOST="${CODESPACE_NAME}-443.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

# Generate VLESS link
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

echo "======================================"
echo " IMPORTANT ACTION REQUIRED "
echo "======================================"
echo ""
echo "You must make port 443 PUBLIC."
echo ""
echo "1. Open:"
echo "https://github.com/codespaces"
echo ""
echo "2. Open your current Codespace"
echo ""
echo "3. Go to:"
echo "Ports -> 443 -> Visibility -> Public"
echo ""
echo "After that, your VLESS link will work."
echo ""

echo "======================================"
echo " LOG FILES "
echo "======================================"
echo ""
echo "Xray log:"
echo "/tmp/xray.log"
echo ""
echo "Keepalive log:"
echo "/tmp/keepalive.log"
echo ""

echo "======================================"
echo " STATUS "
echo "======================================"

if pgrep -f xray >/dev/null; then
    echo "Xray is RUNNING"
else
    echo "Xray FAILED to start"
    echo ""
    echo "Last log output:"
    tail -20 /tmp/xray.log || true
fi

echo "======================================"
