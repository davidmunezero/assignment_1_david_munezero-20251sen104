# **Assignment I: Sunrise Supermarket**

# **Business Scenario**

Sunrise’s management requested a database application that can track their customers, orders, and sales. 

# **Database Used**

I used Oracle 21c to create the database for Sunrise Supermarket.

# **Database Schema**

## ***Relational Schema***
![Database Schema](./images/relational_schema.png) 
## ***SQL Schema***
```sql
CREATE TABLE customers (
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  email VARCHAR2(100),
  city VARCHAR2(50)
);

CREATE TABLE products (
  product_id NUMBER PRIMARY KEY,
  product_name VARCHAR2(100),
  category VARCHAR2(50),
  price NUMBER(10,2)
);

CREATE TABLE orders (
  order_id NUMBER PRIMARY KEY,
  customer_id NUMBER REFERENCES customers(customer_id),
  order_date DATE
);

CREATE TABLE order_items (
  order_item_id NUMBER PRIMARY KEY,
  order_id NUMBER REFERENCES orders(order_id),
  product_id NUMBER REFERENCES products(product_id),
  quantity NUMBER
);
```
# **Creating Database**
![Creating Database](./images/image16.png) 

* Change container to sunrise PDB and grant all privileges to sunrise_admin

![Changing container](./images/image17.png)
![Granting privileges](./images/image6.png)

* Login as sunrise\_admin

![Database login](./images/image10.png)

# **Inserting Data**

I populated the four tables using the import function of SQL Developer. 

![Importing data](./images/image18.png)

**Populated Tables**

***Customers Table***

![customer data](./images/image2.png)

***Products Table***

![product data](./images/image7.png)

***Orders Table***

![orders table](./images/image3.png)

***Order Items Table***

![order items data](./images/image15.png)

**Querries**

## ***Join Querries***

**Query 1:** List every order with the customer's name, city, and order date  

```sql
SELECT o.order_id, c.customer_name, c.city, o.order_date
FROM orders o INNER JOIN customers c
ON o.customer_id = c.customer_id;
```
**Output:** 

![](./images/image9.png)

**Business Interpretation:** This query shows where customers are making orders. It can be useful to management to know where to start targeted geographical marketing campagins.

**Query 2:** List every order item with product name, category, price, and quantity 

```sql
SELECT oi.order_item_id, p.product_name, p.category, p.price, oi.quantity
FROM order_items oi JOIN products p
ON oi.product_id = p.product_id;
```
**Output:** 

![](./images/image8.png)

**Query 3:** List all customers and their orders where they exist, including customers with no orders 

```sql
SELECT c.customer_name, o.order_id, o.order_date
-- use left join to include even customers without orders
FROM customers c LEFT JOIN orders o
ON o.customer_id = c.customer_id;
```

**Output:** 

![](./images/image4.png)

## ***CTE query***

**Task:** Calculate each customer's total spend (quantity x price) and return customers above average spend. 

```sql
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
```
**Output:** 

![](./images/image5.png)

**Business Interpretation:** This query shows management which customers are willing to spend more money on their products.

## ***Window-function queries***

**Query:** Rank customers by total amount spent, highest first. 
