FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    ca-certificates \
    python3 \
    uuid-runtime \
    tzdata

RUN mkdir -p /etc/xray

RUN curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o xray.zip && \
    unzip xray.zip && \
    mv xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf xray.zip *.dat

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 443
EXPOSE 8080

CMD ["sleep", "infinity"]
