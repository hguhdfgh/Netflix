-- ========================================
-- 🚀 نظام إدارة المنتجات المتقدم
-- ========================================
-- شغّل هذا السكريبت بعد QUICK_FIX.sql

-- ========================================
-- 1. جدول المنتجات
-- ========================================
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  icon TEXT,
  color TEXT DEFAULT '#e50914',
  description TEXT,
  is_active BOOLEAN DEFAULT true,
  order_index INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ========================================
-- 2. جدول الحسابات
-- ========================================
CREATE TABLE IF NOT EXISTS accounts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  username TEXT NOT NULL,
  password TEXT NOT NULL,
  duration INTEGER NOT NULL DEFAULT 30,
  status TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'sold', 'expired')),
  purchase_date TIMESTAMP WITH TIME ZONE,
  expiry_date TIMESTAMP WITH TIME ZONE,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ========================================
-- 3. جدول الباقات المخصصة
-- ========================================
CREATE TABLE IF NOT EXISTS product_packages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  duration INTEGER NOT NULL,
  price INTEGER NOT NULL,
  description TEXT,
  features JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ========================================
-- 4. تحديث جدول الطلبات
-- ========================================
ALTER TABLE orders ADD COLUMN IF NOT EXISTS product_id UUID REFERENCES products(id);
ALTER TABLE orders ADD COLUMN IF NOT EXISTS account_id UUID REFERENCES accounts(id);

-- ========================================
-- 5. إضافة الفهارس
-- ========================================
CREATE INDEX IF NOT EXISTS idx_accounts_product_id ON accounts(product_id);
CREATE INDEX IF NOT EXISTS idx_accounts_status ON accounts(status);
CREATE INDEX IF NOT EXISTS idx_accounts_expiry_date ON accounts(expiry_date);
CREATE INDEX IF NOT EXISTS idx_product_packages_product_id ON product_packages(product_id);
CREATE INDEX IF NOT EXISTS idx_orders_product_id ON orders(product_id);
CREATE INDEX IF NOT EXISTS idx_orders_account_id ON orders(account_id);

-- ========================================
-- 6. تفعيل RLS للجداول الجديدة
-- ========================================
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_packages ENABLE ROW LEVEL SECURITY;

-- ========================================
-- 7. إنشاء سياسات RLS
-- ========================================

-- Products: يمكن للجميع قراءة المنتجات النشطة فقط
CREATE POLICY "public_select_products" ON products
  FOR SELECT TO public
  USING (is_active = true);

CREATE POLICY "admin_manage_products" ON products
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- Accounts: يمكن للجميع قراءة الحسابات المتاحة فقط
CREATE POLICY "public_select_available_accounts" ON accounts
  FOR SELECT TO public
  USING (status = 'available');

CREATE POLICY "admin_manage_accounts" ON accounts
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- Product Packages: يمكن للجميع قراءة الباقات
CREATE POLICY "public_select_packages" ON product_packages
  FOR SELECT TO public
  USING (true);

CREATE POLICY "admin_manage_packages" ON product_packages
  FOR ALL TO authenticated
  USING (true) WITH CHECK (true);

-- ========================================
-- 8. إدراج البيانات الافتراضية
-- ========================================

-- المنتجات الافتراضية
INSERT INTO products (name, slug, color, description, order_index, is_active) VALUES
('Netflix', 'netflix', '#e50914', 'أشهر منصة بث الأفلام والمسلسلات', 1, true),
('Spotify', 'spotify', '#1DB954', 'تطبيق الموسيقى الأول عالمياً', 2, true),
('HBO Max', 'hbo', '#6B17E8', 'منصة بث متميزة للمحتوى الحصري', 3, true),
('YouTube Premium', 'youtube', '#FF0000', 'استمتع بـ YouTube بدون إعلانات', 4, true)
ON CONFLICT (slug) DO NOTHING;

-- الباقات الافتراضية لـ Netflix
INSERT INTO product_packages (product_id, duration, price, description, features) 
SELECT id, 30, 1000, 'باقة شهر واحد', '["جودة Full HD", "شاشة واحدة", "دعم فني", "تفعيل فوري"]'::jsonb
FROM products WHERE slug = 'netflix'
ON CONFLICT DO NOTHING;

INSERT INTO product_packages (product_id, duration, price, description, features) 
SELECT id, 90, 2000, 'باقة 3 أشهر', '["جودة 4K", "شاشتان", "دعم VIP", "توفير 1000 دج"]'::jsonb
FROM products WHERE slug = 'netflix'
ON CONFLICT DO NOTHING;

-- الباقات الافتراضية لـ Spotify
INSERT INTO product_packages (product_id, duration, price, description, features) 
SELECT id, 30, 800, 'شهر واحد', '["بدون إعلانات", "جودة عالية", "تحميل الأغاني"]'::jsonb
FROM products WHERE slug = 'spotify'
ON CONFLICT DO NOTHING;

INSERT INTO product_packages (product_id, duration, price, description, features) 
SELECT id, 90, 2200, '3 أشهر', '["بدون إعلانات", "جودة عالية", "تحميل الأغاني", "وفر 200 دج"]'::jsonb
FROM products WHERE slug = 'spotify'
ON CONFLICT DO NOTHING;

-- ========================================
-- 9. التحقق من النجاح
-- ========================================
SELECT 'تم إنشاء جميع الجداول بنجاح!' as status;
SELECT COUNT(*) as products_count FROM products;
SELECT COUNT(*) as packages_count FROM product_packages;

-- ========================================
-- ✅ انتهى الإعداد!
-- ========================================
