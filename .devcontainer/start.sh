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

# پایان پردازش‌های قبلی xray و keepalive
pkill -f xray || true
pkill -f keepalive || true

mkdir -p /etc/xray

# تولید UUID یکبار برای همیشه
if [ ! -f /etc/xray/uuid.txt ]; then
    uuidgen > /etc/xray/uuid.txt
fi

UUID=$(cat /etc/xray/uuid.txt)

echo "UUID = $UUID"
echo ""

# مقداردهی پیش‌فرض متغیرها در صورت نامشخص بودن
if [ -z "$CODESPACE_NAME" ]; then
  CODESPACE_NAME=$(hostname)
fi

if [ -z "$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN" ]; then
  GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN="app.github.dev"
fi

HOST="${CODESPACE_NAME}-443.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"

echo "HOST = $HOST"
echo ""

# جایگذاری UUID در فایل کانفیگ
sed "s/__UUID__/$UUID/g" /config.template.json > /etc/xray/config.json

# اجرای Xray به صورت background و ذخیره لاگ
nohup xray -config /etc/xray/config.json > /tmp/xray.log 2>&1 &

sleep 3

# حلقه keep-alive برای جلوگیری از suspend شدن Codespace
nohup bash -c '
while true
do
  curl -sk https://127.0.0.1:443 >/dev/null 2>&1 || true
  sleep 60
done
' >/tmp/keepalive.log 2>&1 &

VLESS="vless://${UUID}@${HOST}:443?encryption=none&security=none&type=xhttp&path=%2F#codespace-xray"

echo ""
echo "======================================"
echo " XRAY READY "
echo "======================================"
echo ""

echo "VLESS LINK:"
echo "$VLESS"

echo ""
echo "IMPORTANT:"
echo "Ports → set port 443 to PUBLIC"
echo ""

pgrep -f xray && echo "Xray running ✅" || echo "Xray failed ❌"
