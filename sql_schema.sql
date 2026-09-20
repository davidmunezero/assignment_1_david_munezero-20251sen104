-- create PDB
CREATE PLUGGABLE DATABASE sunrise
ADMIN USER sunrise_admin IDENTIFIED BY market
FILE_NAME_CONVERT=
('C:\APP\HP\PRODUCT\21C\ORADATA\XE\PDBSEED\',
 'C:\APP\HP\PRODUCT\21C\ORADATA\XE\sunrise\');

ALTER PLUGGABLE DATABASE sunrise OPEN;
ALTER PLUGGABLE DATABASE sunrise SAVE STATE;

ALTER SESSION SET CONTAINER = sunrise;
GRANT ALL PRIVILEGES TO sunrise_admin;

-- db schema
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