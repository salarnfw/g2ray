FROM ubuntu:22.04

# نصب پکیج‌های مورد نیاز شامل curl و uuidgen
RUN apt-get update && apt-get install -y \
    curl \
    uuid-runtime \
    bash \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# دانلود آخرین نسخه xray و نصب آن
RUN wget -O /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/xray && \
    rm /tmp/xray.zip

# کپی کردن فایل‌های اسکریپت و کانفیگ به کانتینر
COPY start.sh /start.sh
COPY config.template.json /config.template.json



# دادن دسترسی اجرا به اسکریپت استارت
RUN chmod +x /start.sh
# دستور شروع پیش‌فرض کانتینر (می‌توان بعداً override کرد)
CMD ["/start.sh"]
