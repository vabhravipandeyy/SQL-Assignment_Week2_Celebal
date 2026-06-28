-- ============================================================
--  SECTION D: JOINS & RELATIONSHIPS
--  ShopEase E-Commerce Database | Celebal Summer Internship 2026
-- ============================================================


-- Q19. INNER JOIN: Each order with the customer's first and last name.
--      Shows: order_id, order_date, first_name, last_name, total_amount.
SELECT o.order_id,
       o.order_date,
       c.first_name,
       c.last_name,
       o.total_amount
FROM   orders    o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date;
-- Returns only orders that have a matching customer (all 10 in this dataset).


-- Q20. LEFT JOIN: ALL customers and their orders.
--      Customers with no orders still appear with NULL order columns.
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       o.order_id,
       o.order_date,
       o.total_amount
FROM   customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
-- All 8 customers appear. NULL values shown where no order exists.


-- Q21. Three-table JOIN across orders → order_items → products.
--      Shows: order_id, product_name, quantity, unit_price, discount_pct, line_total.
SELECT o.order_id,
       p.product_name,
       oi.quantity,
       oi.unit_price,
       oi.discount_pct,
       ROUND(oi.quantity * oi.unit_price * (1 - oi.discount_pct / 100.0), 2) AS line_total
FROM   orders      o
JOIN   order_items oi ON o.order_id    = oi.order_id
JOIN   products    p  ON oi.product_id = p.product_id
ORDER BY o.order_id, p.product_name;
-- Returns 15 line items across all 10 orders.


-- Q22. Difference between LEFT JOIN and RIGHT JOIN.
--
--   LEFT JOIN  → All rows from LEFT  table; NULLs for unmatched RIGHT rows.
--   RIGHT JOIN → All rows from RIGHT table; NULLs for unmatched LEFT rows.
--
-- Example using this schema:

-- LEFT JOIN (all customers, even those without orders):
SELECT c.first_name, o.order_id
FROM   customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Equivalent RIGHT JOIN (all orders, driving from orders side):
SELECT c.first_name, o.order_id
FROM   orders o
RIGHT JOIN customers c ON c.customer_id = o.customer_id;

-- FULL OUTER JOIN: Returns all rows from BOTH tables,
-- with NULLs where there is no match on either side.
-- Useful when reconciling two lists that may each have unmatched entries.
-- MySQL does not support FULL OUTER JOIN directly — simulate with UNION:
SELECT c.first_name, o.order_id
FROM   customers c LEFT  JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT c.first_name, o.order_id
FROM   customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id;


-- Q23. Foreign Key relationships and referential integrity.
--
--   FK Relationships in schema:
--     orders.customer_id    → customers(customer_id)
--     order_items.order_id  → orders(order_id)
--     order_items.product_id → products(product_id)
--
-- Attempting to insert an order with a non-existent customer_id = 999:
INSERT INTO orders
VALUES (1099, 999, '2024-09-01', 'Pending', 500.00);
--
-- This raises:
--   SQLite → FOREIGN KEY constraint failed
--   MySQL  → ERROR 1452: Cannot add or update a child row: a foreign key constraint fails
--
-- The FK check prevents orphaned records and maintains referential integrity.
