-- ====================================
-- NETFLIX SALES SYSTEM - SUPABASE SETUP
-- ====================================
-- قم بتشغيل هذا السكريبت في Supabase SQL Editor

-- ====================================
-- 1. ORDERS TABLE
-- ====================================
CREATE TABLE IF NOT EXISTS orders (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  customer_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  package_type TEXT NOT NULL CHECK (package_type IN ('1_month', '3_months')),
  payment_method TEXT NOT NULL CHECK (payment_method IN ('baridi_mob', 'ccp', 'flexy')),
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'delivered', 'cancelled')),
  price INTEGER NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_orders_phone ON orders(phone);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);

-- ====================================
-- 2. PAGE CONTENT TABLE
-- ====================================
CREATE TABLE IF NOT EXISTS page_content (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  section TEXT NOT NULL UNIQUE,
  content JSONB NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ====================================
-- 3. FAQs TABLE
-- ====================================
CREATE TABLE IF NOT EXISTS faqs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question TEXT NOT NULL,
  answer TEXT NOT NULL,
  order_index INTEGER NOT NULL DEFAULT 1,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_faqs_order ON faqs(order_index ASC);

-- ====================================
-- 4. INSERT DEFAULT DATA
-- ====================================

-- Hero Content
INSERT INTO page_content (section, content) VALUES 
('hero', '{
  "badge": "متاح الآن",
  "title_text": "شاهد كل ما تحب<br>مع <span class=\"highlight\">Netflix</span>",
  "description": "احصل على حساب Netflix أصلي بأسعار لا تُقاوم. تفعيل فوري، دعم مستمر، وضمان كامل."
}')
ON CONFLICT (section) DO NOTHING;

-- Packages Content
INSERT INTO page_content (section, content) VALUES 
('packages', '[
  {
    "id": "1_month",
    "name": "باقة شهر واحد",
    "duration": "شهر واحد",
    "price": 1000,
    "features": ["حساب Netflix أصلي", "جودة Full HD", "شاشة واحدة", "دعم فني كامل"]
  },
  {
    "id": "3_months",
    "name": "باقة 3 أشهر",
    "duration": "3 أشهر",
    "price": 2000,
    "popular": true,
    "features": ["حساب Netflix أصلي", "جودة Ultra HD 4K", "شاشتين في نفس الوقت", "دعم فني VIP", "وفّر 1000 دج"]
  }
]')
ON CONFLICT (section) DO NOTHING;

-- Payment Methods
INSERT INTO page_content (section, content) VALUES 
('payments', '[
  {"id": "baridi_mob", "name": "Baridi Mob", "icon": "📲", "active": true},
  {"id": "ccp", "name": "CCP", "icon": "🏦", "active": true},
  {"id": "flexy", "name": "Flexy", "icon": "💰", "active": true}
]')
ON CONFLICT (section) DO NOTHING;

-- Default FAQs
INSERT INTO faqs (question, answer, order_index, is_active) VALUES 
('هل الحسابات أصلية؟', 'نعم، جميع الحسابات أصلية 100% ومن Netflix مباشرة. نضمن لك تجربة مشاهدة كاملة بدون أي مشاكل.', 1, true),
('كم يستغرق التفعيل؟', 'يتم التفعيل خلال 30 دقيقة إلى ساعة واحدة بعد تأكيد الدفع. في أغلب الحالات يتم التفعيل خلال دقائق.', 2, true),
('ماذا لو توقف الحساب؟', 'نقدم ضمان كامل طوال مدة الاشتراك. إذا حدث أي مشكل سنقوم باستبدال الحساب فوراً مجاناً.', 3, true),
('كيف أدفع عبر Baridi Mob؟', 'بعد إرسال الطلب سنتواصل معك ونرسل لك رقم الحساب البريدي. تقوم بالتحويل عبر تطبيق Baridi Mob وترسل لنا وصل الدفع.', 4, true),
('هل يمكنني مشاركة الحساب؟', 'يمكنك استخدام الحساب على عدد الشاشات المحدد في باقتك. لا نسمح بمشاركة بيانات الدخول مع أشخاص آخرين خارج الباقة.', 5, true)
ON CONFLICT DO NOTHING;

-- ====================================
-- 5. ROW LEVEL SECURITY (RLS)
-- ====================================

ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE page_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE faqs ENABLE ROW LEVEL SECURITY;

-- Allow public to read FAQs and page content (public read for landing page)
CREATE POLICY "FAQs are publicly readable" ON faqs
  FOR SELECT USING (is_active = true);

CREATE POLICY "Page content is publicly readable" ON page_content
  FOR SELECT USING (true);

-- Allow authenticated users (admin) full access to orders
CREATE POLICY "Authenticated users can manage orders" ON orders
  FOR ALL USING (auth.role() = 'authenticated');

-- Allow public to insert orders (from landing page)
CREATE POLICY "Anyone can insert orders" ON orders
  FOR INSERT WITH CHECK (true);

-- Allow authenticated users to read all orders
CREATE POLICY "Authenticated users can read orders" ON orders
  FOR SELECT USING (auth.role() = 'authenticated');

-- Allow authenticated users to update orders
CREATE POLICY "Authenticated users can update orders" ON orders
  FOR UPDATE USING (auth.role() = 'authenticated');

-- Allow authenticated users to delete orders
CREATE POLICY "Authenticated users can delete orders" ON orders
  FOR DELETE USING (auth.role() = 'authenticated');

-- Admin can manage FAQs and page content
CREATE POLICY "Authenticated users can manage FAQs" ON faqs
  FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Authenticated users can manage page content" ON page_content
  FOR ALL USING (auth.role() = 'authenticated');

-- ====================================
-- 6. CREATE AUTH USERS (Do this in Supabase Auth)
-- ====================================
-- Go to Supabase Dashboard → Authentication → Users
-- Create these users manually:
--
-- Email: admin@netzone.dz
-- Password: NetZone@2026Admin
--
-- Email: support@netzone.dz
-- Password: Support@2026Safe

-- ====================================
-- 7. VERIFY SETUP
-- ====================================
-- Run these queries to verify:
-- SELECT COUNT(*) FROM orders;
-- SELECT * FROM page_content;
-- SELECT * FROM faqs WHERE is_active = true;
