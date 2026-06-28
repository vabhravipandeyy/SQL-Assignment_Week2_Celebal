# SQL Assignment — ShopEase E-Commerce Database
**Celebal Summer Internship 2026 | Week 2**

## Project Overview

This assignment analyzes a fictional e-commerce company called **ShopEase** that sells Electronics, Clothing, and Home products across India. SQL queries are written to extract business insights from a relational database containing customers, products, orders, and order items.

## Database Schema

```
customers ──(1:N)──▶ orders ──(1:N)──▶ order_items ◀──(1:N)── products
```

| Table | Primary Key | Rows |
|---|---|---|
| customers | customer_id | 8 |
| products | product_id | 8 |
| orders | order_id | 10 |
| order_items | item_id | 15 |

## Folder Structure

```
sql-assignment/
│── Section_A/
│   └── basic_queries.sql        ← SELECT, constraints, primary keys (Q1–Q6)
│── Section_B/
│   └── filtering_queries.sql    ← WHERE, indexes, SARGable queries (Q7–Q12)
│── Section_C/
│   └── aggregation_queries.sql  ← GROUP BY, SUM, COUNT, AVG, MIN, MAX (Q13–Q18)
│── Section_D/
│   └── joins_queries.sql        ← INNER JOIN, LEFT JOIN, 3-table JOIN, FK (Q19–Q23)
│── Section_E/
│   └── advanced_queries.sql     ← CASE, ACID, Transactions (Q24–Q27)
│── README.md
```

## How to Run

1. Open any SQL tool — MySQL, PostgreSQL, or SQLite
2. Create a new database: `CREATE DATABASE shopease;`
3. Run the schema + data INSERT statements (included in each section file header or use the combined script)
4. Execute each section file in order: A → B → C → D → E

## Key Business Insights

- **60% fulfillment rate** — 6 out of 10 orders delivered
- **Total delivered revenue: ₹18,191**
- **Electronics** is the top revenue-generating category
- **Clothing** has the highest average price (₹2,699) driven by Nike Running Shoes
- **Aarav Sharma** is the top customer by spend (₹7,997)
- 1 cancelled order = ₹2,999 in lost revenue

## SQL Concepts Covered

| Section | Concepts |
|---|---|
| A | SELECT, DISTINCT, PRIMARY KEY, UNIQUE, CHECK constraints |
| B | WHERE, BETWEEN, AND/OR, Indexes, SARGable queries |
| C | GROUP BY, HAVING, COUNT, SUM, AVG, MIN, MAX |
| D | INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN, Foreign Keys |
| E | CASE WHEN, Conditional aggregation, ACID properties, BEGIN/COMMIT/ROLLBACK |

## Tools Used

- SQL (compatible with MySQL / PostgreSQL / SQLite)
- Standard SQL syntax throughout

---

*Celebal Summer Internship 2026 — Week 2 SQL Task*
