-- join queries

-- qry 1
SELECT o.order_id, c.customer_name, c.city, o.order_date
FROM orders o INNER JOIN customers c
ON o.customer_id = c.customer_id;

-- qry 2
SELECT oi.order_item_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi JOIN products p
ON oi.product_id = p.product_id;

-- qry 3
SELECT c.customer_name, o.order_id, o.order_date
-- use left join to include even customers without orders
FROM customers c LEFT JOIN orders o
ON o.customer_id = c.customer_id;

-- cte query
WITH cte_customer_spend AS (
    -- compute customer's totals 
    SELECT c.customer_name, SUM(oi.quantity * p.price) AS "Total Spend"
    FROM customers c, orders o, products p, order_items oi
    WHERE c.customer_id = o.customer_id AND oi.order_id  = o.order_id 
    AND oi.product_id = p.product_id 
    GROUP BY c.customer_id, c.customer_name
)
-- display only customers above average spend
SELECT * 
FROM cte_customer_spend
WHERE "Total Spend" > (
    SELECT AVG("Total Spend") FROM cte_customer_spend
);

-- window-function queries

-- qry 1
WITH cte_customer_spend AS (
    -- compute customer's totals using all tables
    SELECT c.customer_name, SUM(oi.quantity * p.price) AS "Total Spend"
    FROM customers c, orders o, products p, order_items oi
    WHERE c.customer_id = o.customer_id AND oi.order_id  = o.order_id 
    AND oi.product_id = p.product_id 
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_name, "Total Spend", 
-- define the window function
RANK() OVER(ORDER BY "Total Spend" DESC) as "Rank"
FROM cte_customer_spend;

-- qry 2
SELECT c.customer_name, o.order_id, o.order_date,
-- assign a row number to each customer based on the earlier order_date
ROW_NUMBER() OVER(ORDER BY o.order_date ASC) as "Order Placement"
FROM customers c INNER JOIN orders o
ON o.customer_id = c.customer_id;

-- qry 3
SELECT o.order_id, o.order_date, 
-- partition by to group by order, 
SUM(p.price * oi.quantity) OVER(PARTITION BY o.order_id ORDER BY o.order_date ASC) as "Revenue"
FROM orders o, products p, order_items oi 
WHERE oi.order_id = o.order_id AND oi.product_id = p.product_id;

-- qry 4
SELECT DISTINCT c.customer_name, 
-- calculate the days between current and previous order date
(o.order_date - LAG(o.order_date) OVER(ORDER BY o.order_date ASC)) as "Days Btwn Current and Previous Order"
FROM customers c INNER JOIN orders o ON o.customer_id = c.customer_id
WHERE c.customer_id IN (
    -- find customers who have more than 1 order
    SELECT c.customer_id
    FROM customers c, orders o
    WHERE o.customer_id = c.customer_id
    GROUP BY c.customer_id
    HAVING COUNT(o.order_id) > 1
);