#!/bin/bash
set -e

# رفتن به دایرکتوری خود اسکریپت برای اطمینان از مسیر صحیح فایل‌های وابسته
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# تولید UUID جدید
UUID=$(uuidgen)

# جایگزینی UUID در فایل template و ایجاد config.json نهایی
sed "s/UUID/$UUID/g" config.template.json > config.json

echo "======================================"
echo " Starting Xray Setup "
echo "======================================"
echo ""
echo "DEBUG ENV:"
echo "CODESPACE_NAME=${CODESPACE_NAME:-}"
echo "PORT_DOMAIN=${PUBLIC_DOMAIN:-}"
echo ""
echo "UUID = $UUID"
echo ""
echo "HOST = ${CODESPACE_NAME:-}-443.${PUBLIC_DOMAIN:-}"
echo ""
echo ""
echo "======================================"
echo " XRAY READY "
echo "======================================"
echo ""
echo "VLESS LINK:"
echo "vless://${UUID}@${CODESPACE_NAME:-}-443.${PUBLIC_DOMAIN:-}:443?encryption=none&security=none&type=xhttp&path=%2F#codespace-xray"
echo ""
echo "IMPORTANT:"
echo "Ports → set port 443 to PUBLIC"
echo ""

# اجرای Xray با فایل پیکربندی ساخته شده
xray -config config.json || echo "Xray failed ❌"

echo "Xray running ✅"
