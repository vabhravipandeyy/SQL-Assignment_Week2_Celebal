-- ============================================================
--  SECTION B: FILTERING & OPTIMIZATION — WHERE, Indexes
--  ShopEase E-Commerce Database | Celebal Summer Internship 2026
-- ============================================================


-- Q7. Retrieve all orders with status = 'Delivered'.
SELECT *
FROM orders
WHERE status = 'Delivered';
-- Uses idx_orders_status index for fast lookup. Returns 6 orders.


-- Q8. Find all products in the 'Electronics' category with unit_price > ₹2000.
SELECT *
FROM products
WHERE category = 'Electronics'
  AND unit_price > 2000;
-- Uses idx_products_category. Returns Smart Watch (₹2999) and Bluetooth Speaker (₹3499).


-- Q9. List all customers who joined in 2024 and belong to Maharashtra.
--     SARGable (index-friendly) version — uses range comparison, not YEAR() function.
SELECT *
FROM customers
WHERE join_date >= '2024-01-01'
  AND join_date <  '2025-01-01'
  AND state = 'Maharashtra';
-- Returns: Aarav Sharma (Mumbai) and Karan Mehta (Pune).


-- Q10. Orders placed between 2024-08-10 and 2024-08-25 (inclusive), excluding Cancelled.
SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'
  AND status <> 'Cancelled';
-- BETWEEN is inclusive on both ends. Uses idx_orders_date.
-- Returns 5 orders: 1004, 1006, 1007, 1008, 1009.


-- Q11. How does idx_orders_date improve query performance?
--
--   WITHOUT index: Full table scan — O(n), checks every single row.
--   WITH idx_orders_date: B-tree traversal — O(log n), jumps directly
--   to the matching date range and reads only those rows.
--   Performance benefit grows dramatically as table scales to millions of rows.
--
-- Sample query that directly benefits from this index:
SELECT order_id,
       customer_id,
       total_amount
FROM orders
WHERE order_date BETWEEN '2024-08-01' AND '2024-08-15';


-- Q12. SARGable rewrite — why YEAR() prevents index usage.
--
-- NON-SARGable (index NOT used — function applied to the column):
--   SELECT * FROM customers WHERE YEAR(join_date) = 2024;
--   The YEAR() function is applied to every row → full table scan
--   even if an index exists on join_date.
--
-- SARGable (index CAN be used — column compared directly to values):
SELECT *
FROM customers
WHERE join_date >= '2024-01-01'
  AND join_date <  '2025-01-01';
-- The optimizer can traverse the index B-tree directly for this range.
