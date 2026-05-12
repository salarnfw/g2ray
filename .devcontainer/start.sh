#!/bin/bash

# مسیر پروژه
WORKSPACE_DIR="/workspaces/g2ray/.devcontainer"
UUID_FILE="$WORKSPACE_DIR/.uuid"
CONFIG_TEMPLATE="$WORKSPACE_DIR/config.template.json"
CONFIG_JSON="$WORKSPACE_DIR/config.json"
CONNECTION_FILE="$WORKSPACE_DIR/connection.txt"
LOG_FILE="$WORKSPACE_DIR/xray.log"

# تولید UUID ثابت
if [ ! -f "$UUID_FILE" ]; then
    cat /proc/sys/kernel/random/uuid > "$UUID_FILE"
fi
UUID=$(cat "$UUID_FILE")

# چک اجرای قبلی xray (برای جلوگیری از چندباره اجرا)
if pgrep -x "xray" > /dev/null; then
    echo "Xray is already running."
else
    # ساخت فایل کانفیگ با جایگذاری UUID و HOST (میزبان ثابت، مثلا localhost یا آی‌پی مورد نظر)
    HOST="example.com"  # وقتی Host واقعی داری تغییرش بده

    sed -e "s/{{UUID}}/$UUID/g" -e "s/{{HOST}}/$HOST/g" "$CONFIG_TEMPLATE" > "$CONFIG_JSON"

    # اجرای xray در پس‌زمینه با لاگ گرفتن
    nohup /usr/local/bin/xray -config "$CONFIG_JSON" > "$LOG_FILE" 2>&1 &

    echo "Xray started. Log file: $LOG_FILE"
fi

# ساخت و نمایش لینک اتصال VLESS با رنگ و قالب بندی
VLESS_LINK="vless://$UUID@$HOST:443?security=tls&type=tcp#VLESS-$HOST"

cat <<EOF > "$CONNECTION_FILE"
---------------------------------------
🌟 Xray VLESS Connection Info 🌟

UUID: $UUID
HOST: $HOST

Connection Link:
$VLESS_LINK

Log file:
$LOG_FILE
---------------------------------------
EOF

# نمایش محتویات اتصال در ترمینال
cat "$CONNECTION_FILE"
