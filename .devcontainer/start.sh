#!/bin/bash

set -e

WORKSPACE_DIR="/workspaces/g2ray/.devcontainer"
UUID_FILE="$WORKSPACE_DIR/.uuid"
CONFIG_TEMPLATE="$WORKSPACE_DIR/config.template.json"
CONFIG_JSON="$WORKSPACE_DIR/config.json"
CONNECTION_FILE="$WORKSPACE_DIR/connection.txt"
LOG_FILE="$WORKSPACE_DIR/xray.log"

# گرفتن HOST واقعی از Codespaces forwarding
HOST="${CODESPACE_NAME}-443.app.github.dev"

# اگر UUID وجود ندارد، یک UUID ثابت بساز
if [ ! -f "$UUID_FILE" ]; then
    cat /proc/sys/kernel/random/uuid > "$UUID_FILE"
fi
UUID=$(cat "$UUID_FILE")

# ساخت config.json از template
sed \
  -e "s|{{UUID}}|$UUID|g" \
  -e "s|{{HOST}}|$HOST|g" \
  "$CONFIG_TEMPLATE" > "$CONFIG_JSON"

# اگر xray در حال اجرا نیست، اجرا کن
if pgrep -x "xray" > /dev/null; then
    XRAY_STATUS="Xray is already running."
else
    nohup /usr/local/bin/xray run -c "$CONFIG_JSON" > "$LOG_FILE" 2>&1 &
    sleep 2
    XRAY_STATUS="Xray started successfully."
fi

VLESS_LINK="vless://${UUID}@${HOST}:443?encryption=none&security=tls&type=xhttp&mode=packet-up&sni=${HOST}&path=%2F#GitHub-Tunnel"

cat > "$CONNECTION_FILE" <<EOF
========================================
GitHub Codespaces Xray Connection
========================================

Status:
$XRAY_STATUS

UUID:
$UUID

HOST:
$HOST

VLESS LINK:
$VLESS_LINK

Files:
Config: $CONFIG_JSON
Log:    $LOG_FILE

========================================
EOF

echo
cat "$CONNECTION_FILE"
echo
