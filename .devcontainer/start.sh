#!/usr/bin/env bash
set -e

UUID_FILE=/etc/xray/uuid.txt
CONFIG=/etc/xray/config.json
TEMPLATE=/config.template.json

mkdir -p /etc/xray

# UUID فقط یک‌بار
if [ ! -f "$UUID_FILE" ]; then
  uuidgen > "$UUID_FILE"
fi
UUID=$(cat "$UUID_FILE")

sed "s/__UUID__/$UUID/g" "$TEMPLATE" > "$CONFIG"

# اجرای Xray
/usr/local/bin/xray -config "$CONFIG" >/tmp/xray.log 2>&1 &

# keep-alive داخلی (بدون اینترنت)
(
  while true; do
    curl -s http://127.0.0.1:443 >/dev/null 2>&1 || true
    sleep 60
  done
) &

HOST="${CODESPACE_NAME}-443.app.github.dev"

echo ""
echo "=============================="
echo "Xray READY"
echo "UUID: $UUID"
echo ""
echo "VLESS LINK:"
echo "vless://$UUID@$HOST:443?encryption=none&type=xhttp&mode=packet-up&path=%2F#Codespace-Xray"
echo "=============================="
