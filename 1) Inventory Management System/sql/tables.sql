-- Inventory Management System ki tables
--
-- Supabase Dashboard -> SQL Editor -> New query me ye poora file paste karke Run karein.
-- Ek bar chalana hai. Dobara chalayenge to "already exists" error aayega, wo theek hai.

-- Stock: har product ki ek line. Purchase se quantity barhti hai, sell se kam hoti hai.
create table products (
  id bigint generated always as identity primary key,
  name text not null unique,
  quantity integer not null default 0,
  price numeric not null default 0,
  created_at timestamptz not null default now()
);

-- Har purchase ki ek line, total quantity x price hota hai
-- 1. Purchases table
CREATE TABLE purchases (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(12, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Sales table linked to purchases
CREATE TABLE sales (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    purchase_id BIGINT NOT NULL
        REFERENCES purchases(id),
    customer_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price NUMERIC(12, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Row Level Security: sirf logged in user in tables ko parh aur likh sake.
-- RLS on karne ke baad bina policy ke koi bhi kuch nahi kar sakta, is liye
-- har table par ek policy chahiye.
alter table products enable row level security;
alter table purchases enable row level security;
alter table sales enable row level security;

create policy "logged in users can do everything"
  on products for all to authenticated
  using (true) with check (true);

create policy "logged in users can do everything"
  on purchases for all to authenticated
  using (true) with check (true);

create policy "logged in users can do everything"
  on sales for all to authenticated
  using (true) with check (true);
