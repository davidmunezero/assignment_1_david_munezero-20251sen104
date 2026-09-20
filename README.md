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
