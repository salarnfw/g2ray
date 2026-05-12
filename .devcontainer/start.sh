#!/usr/bin/env bash

set -e

mkdir -p /etc/xray

UUID_FILE=/etc/xray/uuid.txt
TEMPLATE=/config.template.json
CONFIG=/etc/xray/config.json

# ساخت UUID فقط بار اول
if [ ! -f "$UUID_FILE" ]; then
    uuidgen > "$UUID_FILE"
    echo "New UUID generated"
fi

UUID=$(cat "$UUID_FILE")

# ساخت config نهایی
sed "s/__UUID__/$UUID/g" "$TEMPLATE" > "$CONFIG"

# توقف پردازش‌های قبلی
pkill -f xray || true
pkill -f "http.server 8080" || true

# اجرای Xray
nohup /usr/local/bin/xray -config "$CONFIG" > /tmp/xray.log 2>&1 &

echo "Xray started"

# اجرای health server
nohup python3 -m http.server 8080 > /tmp/health.log 2>&1 &

echo "Health server started"

# ساخت hostname
HOST="${CODESPACE_NAME}-443.app.github.dev"

echo ""
echo "=================================="
echo "✅ XRAY RUNNING"
echo "=================================="
echo ""
echo "UUID:"
echo "$UUID"
echo ""
echo "VLESS LINK:"
echo "vless://$UUID@$HOST:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=$HOST&path=%2F#Codespace-Xray"
echo ""
echo "UPTIMEROBOT URL:"
echo "https://${CODESPACE_NAME}-8080.app.github.dev"
echo ""
echo "=================================="
echo ""
