FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update \
 && apt-get install -y curl unzip uuid-runtime \
 && mkdir -p /etc/xray

# install xray
RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o xray.zip \
 && unzip xray.zip \
 && mv xray /usr/local/bin/xray \
 && chmod +x /usr/local/bin/xray \
 && rm -rf xray.zip geo*

COPY start.sh /start.sh
COPY config.template.json /config.template.json

RUN chmod +x /start.sh
