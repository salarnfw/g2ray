FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    ca-certificates \
    python3 \
    uuid-runtime \
    tzdata && \
    rm -rf /var/lib/apt/lists/*

# ساخت پوشه xray
RUN mkdir -p /etc/xray

# دانلود و نصب Xray
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip && \
    cd /tmp && \
    unzip xray.zip && \
    mv xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -f /tmp/xray.zip && \
    rm -f /tmp/*.dat

# کپی فایل‌ها
COPY start.sh /start.sh
COPY config.template.json /config.template.json

# دسترسی اجرا
RUN chmod +x /start.sh

EXPOSE 443
EXPOSE 8080

CMD ["sleep", "infinity"]
