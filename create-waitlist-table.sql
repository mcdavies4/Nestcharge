-- Run this in your Supabase SQL Editor
-- Go to: supabase.com → your project → SQL Editor → New Query

CREATE TABLE IF NOT EXISTS waitlist (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  email text UNIQUE NOT NULL,
  captured_at timestamptz DEFAULT now(),
  source text DEFAULT 'homepage'
);

-- Allow anyone to insert (for the email capture form)
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can join waitlist"
  ON waitlist FOR INSERT
  WITH CHECK (true);

-- Only authenticated users (admin) can read
CREATE POLICY "Admin can read waitlist"
  ON waitlist FOR SELECT
  USING (auth.role() = 'authenticated');
