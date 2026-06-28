-- ============================================================
--  SECTION A: SQL BASICS — SELECT, Constraints, Primary Keys
--  ShopEase E-Commerce Database | Celebal Summer Internship 2026
-- ============================================================


-- Q1. Display all columns and rows from the customers table.
SELECT *
FROM customers;
-- Returns all 8 customer records with every column.


-- Q2. Retrieve only first_name, last_name, and city of all customers.
SELECT first_name,
       last_name,
       city
FROM customers;


-- Q3. List all unique categories available in the products table.
SELECT DISTINCT category
FROM products;
-- Expected: Electronics, Clothing, Home


-- Q4. Primary Keys in the schema:
--
--   Table         | Primary Key  | Data Type
--   --------------|--------------|----------
--   customers     | customer_id  | INT
--   products      | product_id   | INT
--   orders        | order_id     | INT
--   order_items   | item_id      | INT
--
-- Why must a Primary Key be UNIQUE and NOT NULL?
--   UNIQUE  → Every row must be individually identifiable.
--             Duplicate PKs make it impossible to reference a specific record.
--   NOT NULL → A NULL value means "unknown". A PK that is NULL cannot
--              uniquely identify any row, breaking referential integrity.


-- Q5. Constraints on the email column in customers:
--     Applied constraints: UNIQUE and NOT NULL
--
--     If you try to INSERT a duplicate email, the database raises:
--       SQLite  → ERROR: UNIQUE constraint failed: customers.email
--       MySQL   → ERROR 1062: Duplicate entry for key 'email'
--
-- Demonstration (this INSERT will FAIL):
INSERT INTO customers
VALUES (109, 'Test', 'User', 'aarav.s@email.com', 'Mumbai', 'Maharashtra', '2024-09-01', FALSE);


-- Q6. Inserting a product with unit_price = -50 (violates CHECK constraint).
--
-- This INSERT will FAIL with:
--   ERROR: CHECK constraint failed: unit_price > 0
--
-- The CHECK (unit_price > 0) on the products table prevents
-- any negative or zero price from being stored.
INSERT INTO products
VALUES (209, 'Broken Product', 'Electronics', 'TestBrand', -50.00, 100);
