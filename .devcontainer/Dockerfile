FROM mcr.microsoft.com/devcontainers/base:ubuntu

# نصب ابزارهای پایه + uuid-runtime + unzip
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    curl \
    wget \
    vim \
    ca-certificates \
    uuid-runtime \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# نصب Xray
RUN cd /tmp \
 && curl -L -o xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
 && unzip xray-linux-64.zip -d xray-dist \
 && mv xray-dist/xray /usr/local/bin/xray \
 && chmod +x /usr/local/bin/xray \
 && rm -rf xray-dist xray-linux-64.zip

# کپی فایل‌ها
COPY start.sh /start.sh
COPY config.template.json /config.template.json

# مجوز اجرا
RUN chmod +x /start.sh

USER root
EXPOSE 443
CMD ["/bin/bash"]
