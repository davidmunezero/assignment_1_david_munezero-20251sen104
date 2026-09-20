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
