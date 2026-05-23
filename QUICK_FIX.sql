-- ========================================
-- 🚨 الحل السريع للمشكلة - شغّل هذا الآن
-- ========================================
-- انسخ كل هذا الملف والصقه في Supabase SQL Editor واضغط RUN

-- خطوة 1: حذف كل السياسات القديمة
DROP POLICY IF EXISTS "Anyone can insert orders" ON orders;
DROP POLICY IF EXISTS "Authenticated users can manage orders" ON orders;
DROP POLICY IF EXISTS "Authenticated users can read orders" ON orders;
DROP POLICY IF EXISTS "Authenticated users can update orders" ON orders;
DROP POLICY IF EXISTS "Authenticated users can delete orders" ON orders;
DROP POLICY IF EXISTS "Allow public insert orders" ON orders;
DROP POLICY IF EXISTS "Allow authenticated read orders" ON orders;
DROP POLICY IF EXISTS "Allow authenticated update orders" ON orders;
DROP POLICY IF EXISTS "Allow authenticated delete orders" ON orders;

DROP POLICY IF EXISTS "FAQs are publicly readable" ON faqs;
DROP POLICY IF EXISTS "Authenticated users can manage FAQs" ON faqs;
DROP POLICY IF EXISTS "Allow public read active faqs" ON faqs;
DROP POLICY IF EXISTS "Allow authenticated manage faqs" ON faqs;

DROP POLICY IF EXISTS "Page content is publicly readable" ON page_content;
DROP POLICY IF EXISTS "Authenticated users can manage page content" ON page_content;
DROP POLICY IF EXISTS "Allow public read page_content" ON page_content;
DROP POLICY IF EXISTS "Allow authenticated manage page_content" ON page_content;

-- خطوة 2: تفعيل RLS
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE faqs ENABLE ROW LEVEL SECURITY;
ALTER TABLE page_content ENABLE ROW LEVEL SECURITY;

-- خطوة 3: السماح للجميع بإضافة طلبات (السياسة الحاسمة!)
CREATE POLICY "public_insert_orders" ON orders
  FOR INSERT TO public
  WITH CHECK (true);

CREATE POLICY "public_select_orders" ON orders
  FOR SELECT TO public
  USING (true);

CREATE POLICY "public_update_orders" ON orders
  FOR UPDATE TO public
  USING (true) WITH CHECK (true);

CREATE POLICY "public_delete_orders" ON orders
  FOR DELETE TO public
  USING (true);

-- خطوة 4: السماح للجميع بقراءة faqs و page_content
CREATE POLICY "public_select_faqs" ON faqs
  FOR SELECT TO public
  USING (true);

CREATE POLICY "public_manage_faqs" ON faqs
  FOR ALL TO public
  USING (true) WITH CHECK (true);

CREATE POLICY "public_select_page_content" ON page_content
  FOR SELECT TO public
  USING (true);

CREATE POLICY "public_manage_page_content" ON page_content
  FOR ALL TO public
  USING (true) WITH CHECK (true);

-- ✅ تم!
SELECT 'تم إصلاح الصلاحيات بنجاح!' as status;
