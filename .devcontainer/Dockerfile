FROM mcr.microsoft.com/devcontainers/base:ubuntu

# نصب ابزارهای مورد نیاز از جمله git، curl، uuid-runtime، unzip و ...
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    curl \
    wget \
    vim \
    ca-certificates \
    uuid-runtime \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# دانلود و نصب هسته Xray
RUN cd /tmp \
 && curl -L -o xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
 && unzip xray-linux-64.zip -d xray-dist \
 && mv xray-dist/xray /usr/local/bin/xray \
 && chmod +x /usr/local/bin/xray \
 && rm -rf xray-dist xray-linux-64.zip

# کپی فایل‌های اسکریپت و پیکربندی به داخل کانتینر
COPY start.sh /workspaces/g2ray/.devcontainer/start.sh
COPY config.template.json /workspaces/g2ray/.devcontainer/config.template.json

# دسترسی اجرایی به start.sh
RUN chmod +x /workspaces/g2ray/.devcontainer/start.sh

USER root
EXPOSE 443

CMD ["/bin/bash"]
