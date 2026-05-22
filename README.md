# NetZone - نظام بيع حسابات Netflix

نظام متكامل لبيع حسابات Netflix في الجزائر مع لوحة تحكم CRM كاملة

## 🎯 المميزات

### صفحة الهبوط (Landing Page)
✅ تصميم عصري وجذاب بواجهة RTL عربية
✅ عرض الباقات والأسعار
✅ نموذج طلب متقدم مع التحقق من البيانات
✅ اختيار وسائل دفع جزائرية (Baridi Mob, CCP, Flexy)
✅ أسئلة شائعة ديناميكية
✅ تحميل محتوى من Supabase
✅ رسائل توصيل فوري للعميل
✅ Responsive design لجميع الأجهزة

### لوحة التحكم (Admin Dashboard)
✅ لوحة معلومات شاملة بإحصائيات فورية
✅ إدارة الطلبات (عرض، تعديل، حذف، تصدير CSV)
✅ إدارة العملاء مع قيمة العميل الكلية (CLV)
✅ إدارة المحتوى (تعديل Hero, الباقات, FAQ)
✅ الإعدادات (وسائل دفع، إشعارات، ألوان العلامة)
✅ رسوم بيانية للمبيعات والدفع
✅ بحث وتصفية متقدمة
✅ نظام تعديل حالات الطلبات
✅ تصدير البيانات إلى CSV
✅ نظام مصادقة آمن

## 📋 المتطلبات

### قبل البدء
- حساب Supabase مجاني أو مدفوع
- متصفح حديث (Chrome, Firefox, Safari, Edge)
- محرر نصوص (VS Code, Sublime, إلخ)

### بيانات اعتماد المسؤول الافتراضية
```
البريد الإلكتروني: admin@netzone.dz
كلمة المرور: NetZone@2026Admin

البريد الإلكتروني 2: support@netzone.dz
كلمة المرور 2: Support@2026Safe
```

## 🚀 خطوات التثبيت

### 1️⃣ إعداد Supabase

#### أ) إنشاء Project جديد
1. اذهب إلى [supabase.com](https://supabase.com)
2. سجل الدخول أو أنشئ حساب جديد
3. اضغط "New Project"
4. أدخل اسم المشروع (مثل: netflix-sales)
5. أدخل كلمة مرور قوية للـ Database
6. اختر المنطقة الأقرب لك
7. انتظر إنشاء المشروع (2-3 دقائق)

#### ب) نسخ مفاتيح API
1. اذهب إلى **Settings → API**
2. انسخ:
   - **Project URL** (SUPABASE_URL)
   - **anon public** (SUPABASE_ANON_KEY)
3. احفظ هذه المفاتيح في مكان آمن

#### ج) إنشاء الجداول والبيانات
1. اذهب إلى **SQL Editor**
2. اضغط "New query"
3. افتح ملف `setup.sql` من المشروع
4. انسخ كل المحتوى والصقه
5. اضغط "RUN" أو Ctrl+Enter
6. تحقق من عدم وجود أخطاء

#### د) إنشاء مستخدمي المسؤول
1. اذهب إلى **Authentication → Users**
2. اضغط "Invite user" أو "Add user manually"
3. أدخل البيانات الأولى:
   - **Email:** admin@netzone.dz
   - **Password:** NetZone@2026Admin
4. كرر للمستخدم الثاني:
   - **Email:** support@netzone.dz
   - **Password:** Support@2026Safe

### 2️⃣ إعداد ملفات المشروع

#### أ) تحديث متغيرات البيئة
1. افتح ملف `.env.example`
2. أدخل قيم SUPABASE_URL و SUPABASE_ANON_KEY التي نسختها
3. احفظ الملف باسم `.env.local` (اختياري للتطوير)

#### ب) تحديث المفاتيح في الملفات
في `index.html` و `dashboard.html`:
```javascript
// ابحث عن:
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';

// استبدل ب:
const SUPABASE_URL = 'https://your-project.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIs...';
```

### 3️⃣ نشر المشروع على GitHub Pages

#### أ) إنشاء Repository جديد
1. اذهب إلى [github.com](https://github.com)
2. اضغط "New repository"
3. اسم: `netflix-sales` (أو أي اسم)
4. اختر "Public"
5. لا تضف README أو gitignore الآن
6. اضغط "Create repository"

#### ب) رفع الملفات
```bash
# نسخ الأوامر من GitHub بعد إنشاء Repository
git init
git add .
git commit -m "Initial commit: Netflix Sales System"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/netflix-sales.git
git push -u origin main
```

#### ج) فعّل GitHub Pages
1. اذهب إلى Settings → Pages
2. Source: Select branch → "main"
3. Folder: "/ (root)"
4. اضغط Save
5. سيظهر رابط موقعك في البريد الإلكتروني

#### د) الوصول للموقع
- **الصفحة الرئيسية:** `https://YOUR_USERNAME.github.io/netflix-sales/`
- **لوحة التحكم:** `https://YOUR_USERNAME.github.io/netflix-sales/dashboard.html`

## 📝 المحتويات المضمنة

### الملفات الرئيسية
```
netflix-sales/
├── index.html           # صفحة الهبوط الرئيسية
├── dashboard.html       # لوحة التحكم (CRM)
├── setup.sql            # سكريبت إعداد قاعدة البيانات
├── .env.example         # متغيرات البيئة (نموذج)
├── README.md            # هذا الملف
└── .gitignore          # استثناءات Git
```

## 🔐 بيانات المسؤول

### الحساب الأول (رئيسي)
- **البريد:** admin@netzone.dz
- **كلمة المرور:** NetZone@2026Admin
- **الدور:** مدير النظام (حقوق كاملة)

### الحساب الثاني (دعم)
- **البريد:** support@netzone.dz
- **كلمة المرور:** Support@2026Safe
- **الدور:** مسؤول دعم العملاء

### ⚠️ أمان مهم
**غيّر كلمات المرور الافتراضية فوراً بعد البدء**
1. في لوحة التحكم، اذهب إلى Authentication في Supabase
2. عدّل كل مستخدم
3. اختر كلمات مرور قوية (15+ حرف مع أحرف وأرقام ورموز)

## 💾 قاعدة البيانات

### جداول Supabase

#### 1. **orders** (الطلبات)
```
- id: UUID
- customer_name: نص (اسم العميل)
- phone: نص (رقم الهاتف الجزائري)
- email: نص اختياري
- package_type: 1_month أو 3_months
- payment_method: baridi_mob, ccp, أو flexy
- status: pending, confirmed, delivered, cancelled
- price: رقم (السعر بـ دينار)
- created_at: الوقت
- updated_at: آخر تحديث
```

#### 2. **page_content** (محتوى الموقع)
```
- id: UUID
- section: نص فريد (hero, packages, payments)
- content: JSON (البيانات الديناميكية)
- updated_at: آخر تحديث
```

#### 3. **faqs** (الأسئلة الشائعة)
```
- id: UUID
- question: نص السؤال
- answer: نص الإجابة
- order_index: رقم الترتيب
- is_active: نعم/لا
- created_at: الوقت
- updated_at: آخر تحديث
```

## 🎨 التخصيص

### تغيير الألوان
في الملفات HTML، ابحث عن `--accent-red: #e50914` وغيّرها

### تغيير الأسعار
في `setup.sql`، عدّل قيم السعر في جدول packages

### تغيير وسائل الدفع
1. اذهب إلى لوحة التحكم
2. اذهب إلى الإعدادات
3. عدّل وسائل الدفع المتاحة

### تغيير المحتوى
1. صفحة الهبوط: صفحة المحتوى في لوحة التحكم
2. الأسئلة الشائعة: إضافة/حذف من لوحة التحكم

## 📊 الإحصائيات والتقارير

### لوحة المعلومات
- إجمالي الطلبات
- إجمالي المبيعات (دج)
- الطلبات المكتملة
- الطلبات المعلقة
- رسم بياني للمبيعات (آخر 7 أيام)
- توزيع طرق الدفع

### إدارة الطلبات
- جدول كامل بجميع الطلبات
- بحث وتصفية متقدمة
- تصدير إلى CSV
- تغيير الحالة مباشرة

### إدارة العملاء
- قائمة العملاء بـ CLV
- عدد طلبات كل عميل
- إجمالي مشترياتهم
- آخر طلب لهم

## 🔄 التحديثات المستقبلية

المميزات المخطط إضافتها:
- [ ] إرسال رسائل SMS للعملاء
- [ ] إرسال بريد إلكتروني تلقائي
- [ ] تقارير شهرية
- [ ] تطبيق موبايل
- [ ] دعم الدفع أون لاين (CIB، Edahabia)
- [ ] نظام العروض والخصومات
- [ ] إدارة المستخدمين المتعددين

## 🐛 استكشاف الأخطاء

### المشكلة: الصفحة لا تحمل البيانات
**الحل:**
1. تحقق من مفاتيح SUPABASE_URL و SUPABASE_ANON_KEY
2. افتح Console (F12) وابحث عن الأخطاء
3. تأكد من أن Supabase Project نشط

### المشكلة: لا يمكن تسجيل الدخول
**الحل:**
1. تحقق من البريد وكلمة المرور
2. تأكد من أن المستخدم موجود في Authentication
3. حاول إعادة تحميل الصفحة

### المشكلة: الطلبات لا تُحفظ
**الحل:**
1. افتح Console وابحث عن الأخطاء
2. تحقق من الاتصال بـ Supabase
3. تأكد من صحة البيانات المُدخلة (رقم الهاتف 10 أرقام)

## 📞 الدعم والمساعدة

### الأسئلة الشائعة

**س: هل المشروع مجاني؟**
ج: نعم، المشروع مجاني تماماً. Supabase يوفر 500MB مجاني.

**س: هل يمكن استخدام اسم نطاق خاص؟**
ج: نعم، في إعدادات GitHub Pages، أضف اسم النطاق الخاص.

**س: كم عدد الطلبات التي يمكن تخزينها؟**
ج: المجاني يدعم ملايين السجلات (500MB ≈ 1 مليون طلب).

**س: هل يمكن إضافة مستخدمين إضافيين؟**
ج: نعم، أضفهم من Supabase Authentication → Users.

## 📜 الترخيص

هذا المشروع مفتوح المصدر ومتاح للاستخدام الشخصي والتجاري.

## 🎓 الموارد المفيدة

- [Supabase Docs](https://supabase.com/docs)
- [GitHub Pages Guide](https://pages.github.com)
- [HTML5 Spec](https://html.spec.whatwg.org)
- [JavaScript MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

## ✅ Checklist التثبيت

- [ ] إنشاء حساب Supabase
- [ ] نسخ مفاتيح API
- [ ] تشغيل setup.sql
- [ ] إنشاء مستخدمي المسؤول
- [ ] تحديث المفاتيح في HTML
- [ ] إنشاء Repository على GitHub
- [ ] رفع الملفات
- [ ] تفعيل GitHub Pages
- [ ] اختبار صفحة الهبوط
- [ ] اختبار لوحة التحكم
- [ ] تغيير كلمات المرور الافتراضية

---

**تم الإنشاء:** 2026-05-20
**الإصدار:** 1.0.0
**الحالة:** جاهز للإنتاج ✅

للمساعدة أو الإبلاغ عن المشاكل، يرجى فتح Issue في GitHub.
