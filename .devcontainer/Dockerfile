# 1️⃣ ایمیج پایه
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# 2️⃣ نصب ابزارهای لازم
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    curl \
    wget \
    vim \
    ca-certificates \
    uuid-runtime \
 && rm -rf /var/lib/apt/lists/*

# 3️⃣ کپی فایل‌ها
COPY start.sh /start.sh
COPY config.template.json /config.template.json

# 4️⃣ مجوز اجرا
RUN chmod +x /start.sh

# 5️⃣ کاربر
USER root

# 6️⃣ پورت
EXPOSE 443

# 7️⃣ دستور پیش‌فرض
CMD ["/bin/bash"]
