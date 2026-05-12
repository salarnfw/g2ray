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
