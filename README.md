
markdown
# Xray on GitHub Codespaces (VLESS + xhttp)

راه‌اندازی خودکار Xray (VLESS) روی GitHub Codespaces با هدف:
- اجرای پایدار بدون Suspend شدن
- ساخت UUID منحصر‌به‌فرد برای هر Fork
- عدم نیاز به سرویس مانیتور خارجی
- اجرای کاملاً اتوماتیک پس از ساخت Codespace

---

## قابلیت‌ها

- ✅ ساخت UUID فقط یک‌بار (Unique برای هر Codespace)
- ✅ اجرای خودکار Xray در Start
- ✅ جلوگیری از Idle Suspend با Keep-Alive لوکال
- ✅ تولید خودکار لینک VLESS
- ✅ بدون نیاز به UptimeRobot
- ✅ مناسب Fork و استفاده عمومی

---

## مراحل راه‌اندازی (بسیار ساده)

### 1️⃣ ساخت Codespace

در صفحه ریپو:
Code → Codespaces → Create codespace

text

پس از Build شدن، اسکریپت `start.sh` به‌صورت خودکار اجرا می‌شود.

---

### 2️⃣ Public کردن پورت 443 (الزامی)

> ⚠️ این تنها مرحله دستی است (به دلیل محدودیت امنیتی GitHub)

1. داخل محیط Codespace
2. تب **Ports**
3. پیدا کردن پورت **443**
4. تغییر **Visibility → Public**

✅ این کار فقط یک‌بار انجام می‌شود.

---

### 3️⃣ دریافت لینک اتصال

پس از اجرا، در ترمینال خروجی زیر نمایش داده می‌شود:
XRAY READY

UUID:

xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

VLESS LINK:

vless://…

text

همان لینک را در کلاینت خود وارد کنید.

---

## کلاینت‌های پیشنهادی

- Android: **v2rayNG / Nekobox**
- Windows: **v2rayN**
- iOS: **Shadowrocket / Nekobox**

---

## نکات مهم

- UUID برای هر Fork و هر Codespace منحصر‌به‌فرد است.
- کانفیگ نهایی هنگام اجرا ساخته می‌شود.
- Xray روی پورت 443 و پروتکل xhttp اجرا می‌شود.
- Keep-Alive داخلی از Suspend شدن جلوگیری می‌کند.
- لاگ‌ها در مسیر `/tmp` ذخیره می‌شوند.

---

## فایل‌های پروژه
.

├── .devcontainer/

│ └── devcontainer.json

├── Dockerfile

├── start.sh

├── config.template.json

├── install.sh

└── README.md

text

---

## عیب‌یابی

- اتصال برقرار نمی‌شود → پورت 443 حتماً Public باشد، لینک صحیح استفاده شود، لاگ را ببینید `/tmp/xray.log`
- Codespace Suspend می‌شود → مطمئن شوید start.sh اجرا و یکی از پردازش‌های مربوط به keep-alive فعال است

---

## امنیت

- UUID به‌صورت تصادفی و محلی ساخته می‌شود
- اطلاعات حساس در ریپو نیست
- Public کردن پورت انتخاب کاربر است

---

## مجوز

برای اهداف آموزشی است؛ مسئولیت استفاده با کاربر است.
