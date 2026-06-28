-- ============================================================
--  SECTION C: AGGREGATION — GROUP BY, SUM, COUNT, AVG, MIN, MAX
--  ShopEase E-Commerce Database | Celebal Summer Internship 2026
-- ============================================================


-- Q13. Count the total number of orders in the orders table.
SELECT COUNT(*) AS total_orders
FROM orders;
-- Result: 10


-- Q14. Find the total revenue from all 'Delivered' orders.
SELECT SUM(total_amount) AS total_delivered_revenue
FROM orders
WHERE status = 'Delivered';
-- Result: ₹18,191


-- Q15. Calculate the average unit_price of products in each category.
SELECT   category,
         ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM     products
GROUP BY category
ORDER BY avg_unit_price DESC;
-- Electronics: ₹2,224 | Clothing: ₹2,699 | Home: ₹949


-- Q16. For each order status, find count of orders and total revenue.
--      Sorted by total revenue in descending order.
SELECT   status,
         COUNT(*)          AS order_count,
         SUM(total_amount) AS total_revenue
FROM     orders
GROUP BY status
ORDER BY total_revenue DESC;


-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category.
SELECT   category,
         MAX(unit_price) AS most_expensive,
         MIN(unit_price) AS cheapest
FROM     products
GROUP BY category;


-- Q18. List all product categories where average unit_price is greater than ₹2000.
--      Uses HAVING clause to filter after aggregation.
SELECT   category,
         ROUND(AVG(unit_price), 2) AS avg_price
FROM     products
GROUP BY category
HAVING   AVG(unit_price) > 2000;
-- Result: Clothing (₹2,699) and Electronics (₹2,224)
