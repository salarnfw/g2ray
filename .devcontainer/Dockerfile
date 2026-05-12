FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    uuid-runtime \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# نصب آخرین نسخه Xray Core
RUN XRAY_ARCH=$(uname -m) && \
    if [ "$XRAY_ARCH" = "x86_64" ]; then XRAY_ARCH="amd64"; fi && \
    if [ "$XRAY_ARCH" = "aarch64" ]; then XRAY_ARCH="arm64"; fi && \
    curl -L -o /tmp/xray.zip "https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${XRAY_ARCH}.zip" && \
    unzip /tmp/xray.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/xray && \
    rm /tmp/xray.zip

COPY start.sh /start.sh
COPY config.template.json /config.template.json

RUN chmod +x /start.sh

CMD ["sleep", "infinity"]
