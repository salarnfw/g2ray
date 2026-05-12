# 1️⃣ ایمیج پایه (استاندارد Devcontainers با Ubuntu)
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# 2️⃣ به‌روزرسانی و نصب ابزارهای لازم
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    curl \
    wget \
    vim \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# 3️⃣ کپی فایل‌ها (همگی در کنار همین Dockerfile داخل .devcontainer هستند)
COPY start.sh /start.sh
COPY config.template.json /config.template.json

# 4️⃣ تنظیم مجوز اجرا برای اسکریپت شروع
RUN chmod +x /start.sh

# 5️⃣ تنظیم کاربر پیش‌فرض برای VSCode
USER root

# 6️⃣ پورت‌ها (همان پورت 443 برای HTTPS)
EXPOSE 443

# 7️⃣ دستور نهایی (اختیاری، Devcontainer معمولاً از postStartCommand در devcontainer.json استفاده می‌کند)
CMD ["/bin/bash"]
