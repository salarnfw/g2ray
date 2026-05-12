FROM debian:12-slim

RUN apt update && apt install -y \
    curl wget unzip uuid-runtime \
    && rm -rf /var/lib/apt/lists/*

COPY install.sh /install.sh
RUN chmod +x /install.sh && /install.sh

COPY config.template.json /config.template.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["bash", "/start.sh", "&&", "sleep", "infinity"]
