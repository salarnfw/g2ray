#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_TEMPLATE="$SCRIPT_DIR/config.template.json"
CONFIG="$SCRIPT_DIR/config.json"
LOG_FILE="$SCRIPT_DIR/xray.log"
OUT_FILE="$SCRIPT_DIR/connection.txt"

# پاک کردن خروجی قبلی
: > "$OUT_FILE"
: > "$LOG_FILE"

# ساخت UUID جدید
UUID=$(cat /proc/sys/kernel/random/uuid)

# ساخت هاست Codespace
HOST="${CODESPACE_NAME}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

# تولید config نهایی از template
sed "s/UUID/$UUID/g; s/HOST/$HOST/g" "$CONFIG_TEMPLATE" > "$CONFIG"

# اجرای Xray در پس‌زمینه
xray -config "$CONFIG" > "$LOG_FILE" 2>&1 &

# کمی صبر برای بالا آمدن سرویس
sleep 2

VLESS_LINK="vless://${UUID}@${HOST}:443?encryption=none&security=none&type=xhttp&path=%2F#codespace-xray"

{
  echo "======================================"
  echo " XRAY READY "
  echo "======================================"
  echo
  echo "UUID:"
  echo "$UUID"
  echo
  echo "HOST:"
  echo "$HOST"
  echo
  echo "VLESS LINK:"
  echo
  echo "$VLESS_LINK"
  echo
  echo "LOG FILE:"
  echo "$LOG_FILE"
  echo
  echo "CONNECTION FILE:"
  echo "$OUT_FILE"
  echo
  echo "Xray running ✅"
  echo "======================================"
} | tee "$OUT_FILE"
