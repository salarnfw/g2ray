FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    uuid-runtime \
    openssl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# نصب Xray
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o /tmp/xray.zip \
    && unzip /tmp/xray.zip -d /tmp/xray \
    && install /tmp/xray/xray /usr/local/bin/xray \
    && chmod +x /usr/local/bin/xray \
    && rm -rf /tmp/xray /tmp/xray.zip

# ساخت self-signed cert برای TLS
RUN openssl req -x509 -nodes -days 3650 \
    -newkey rsa:2048 \
    -keyout /tmp/key.pem \
    -out /tmp/cert.pem \
    -subj "/CN=localhost"

RUN mkdir -p /workspaces/g2ray/.devcontainer \
    && mv /tmp/cert.pem /workspaces/g2ray/.devcontainer/cert.pem \
    && mv /tmp/key.pem /workspaces/g2ray/.devcontainer/key.pem
