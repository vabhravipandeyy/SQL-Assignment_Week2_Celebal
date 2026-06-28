-- ============================================================
--  SECTION E: ADVANCED — CASE, ACID, Transactions
--  ShopEase E-Commerce Database | Celebal Summer Internship 2026
-- ============================================================


-- Q24. Classify products into price tiers using CASE.
--      Budget     → unit_price < 1000
--      Mid-Range  → unit_price BETWEEN 1000 AND 3000
--      Premium    → unit_price > 3000
SELECT product_name,
       unit_price,
       CASE
           WHEN unit_price < 1000                THEN 'Budget'
           WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
           ELSE                                       'Premium'
       END AS price_tier
FROM  products
ORDER BY unit_price;


-- Q25. Count Delivered vs Not-Delivered orders in a single row
--      using CASE inside SUM (pivot technique).
SELECT
    SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_count,
    SUM(CASE WHEN status <> 'Delivered' THEN 1 ELSE 0 END) AS not_delivered_count
FROM orders;
-- Result: Delivered = 6, Not Delivered = 4


-- Q26. ACID Properties — Explanation with real-world bank transfer example:
--
--  A — Atomicity:
--        A transaction is all-or-nothing. If any step fails, every previous
--        step in the same transaction is rolled back automatically.
--        Example: Deducting ₹5000 from Account A AND crediting Account B must
--        both succeed. If the credit fails, the debit is also undone.
--
--  C — Consistency:
--        A transaction moves the database from one valid state to another.
--        All constraints, rules, and triggers must hold before and after.
--        Example: After the transfer, the total money in the system must
--        remain the same — no money is created or destroyed.
--
--  I — Isolation:
--        Concurrent transactions do not see each other's intermediate states.
--        Example: While the transfer is in progress, a simultaneous balance
--        query sees either the pre-transfer or post-transfer balance — never
--        a half-completed in-between state.
--
--  D — Durability:
--        Once committed, changes persist even if the server crashes immediately
--        after. Write-ahead logs and disk flushes guarantee this.
--        Example: After the bank app shows "Transfer Successful", a power
--        outage will not reverse the transfer.


-- Q27. Complete transaction — insert new order 1011 with two items
--      and update product stock atomically.
--      If any step fails → ROLLBACK everything. Otherwise → COMMIT.

BEGIN;

    -- Step 1: Insert the new order
    INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
    VALUES (1011, 102, CURRENT_DATE, 'Pending', 1598.00);

    -- Step 2a: Insert first order item — Laptop Stand (product 207), qty 1
    INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct)
    VALUES (5016, 1011, 207, 1, 899.00, 0);

    -- Step 2b: Insert second order item — Cushion Covers Set (product 208), qty 1
    INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct)
    VALUES (5017, 1011, 208, 1, 599.00, 0);

    -- Step 3a: Deduct stock for Laptop Stand (qty ordered = 1)
    UPDATE products
    SET    stock_qty = stock_qty - 1
    WHERE  product_id = 207;

    -- Step 3b: Deduct stock for Cushion Covers Set (qty ordered = 1)
    UPDATE products
    SET    stock_qty = stock_qty - 1
    WHERE  product_id = 208;

COMMIT;
-- If any statement above raised an error, run ROLLBACK instead:
-- ROLLBACK;
