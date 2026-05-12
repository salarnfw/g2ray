#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

UUID_FILE=".uuid"

# اگر UUID قبلاً ساخته شده همان را استفاده کن
if [ -f "$UUID_FILE" ]; then
    UUID=$(cat "$UUID_FILE")
else
    UUID=$(uuidgen)
    echo "$UUID" > "$UUID_FILE"
fi

# ساخت config
sed "s/UUID/$UUID/g" config.template.json > config.json

HOST="${CODESPACE_NAME:-codespace}-443.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN:-app.github.dev}"

echo ""
echo "======================================"
echo " XRAY READY "
echo "======================================"
echo ""
echo "UUID:"
echo "$UUID"
echo ""
echo "HOST:"
echo "$HOST"
echo ""
echo "VLESS LINK:"
echo ""
echo "vless://${UUID}@${HOST}:443?encryption=none&security=none&type=xhttp&path=%2F#codespace-xray"
echo ""
echo "======================================"
echo ""

# اگر xray قبلاً اجرا شده بود ببند
pkill xray 2>/dev/null || true

# اجرای xray در بک‌گراند
nohup xray -config config.json > xray.log 2>&1 &

sleep 2

if pgrep xray >/dev/null; then
    echo "Xray running ✅"
else
    echo "Xray failed ❌"
    cat xray.log
fi
