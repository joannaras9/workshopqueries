


-select/ dispaly all from customer
SELECT * FROM Customer;

- select first and last name form customer where cust type is 1 billpay
SELECT cust_fname, cust_lname FROM Customer WHERE fk_customer_type_id = 1;  

-show first name from customer that start with s
SELECT cust_fname FROM Customer WHERE cust_fname like 's%' ;

--dispaly all state_code, distict or unique , so even you have repeated values it will only return it once 
SELECT DISTINCT state_code FROM Addresses ;
---show first 5 customers based on customer id
SELECT customer_id, cust_fname, cust_lname FROM Customer LIMIT 5;
-- display csutomer id , first name and last name , use LIMIT keyword to show only 10 values , starting from 1
SELECT customer_id, cust_fname, cust_lname FROM Customer LIMIT 0, 10;

--displays 21 values , from 10th till 30th
SELECT customer_id, cust_fname, cust_lname FROM Customer LIMIT 9, 21;

--show resuls of customer name alphabeticaly
SELECT cust_fname, cust_lname FROM customer ORDER BY cust_fname;

--filter data, show customer with id number 5, = is condtion , what result you want to be condition by
SELECT customer_id, cust_fname, cust_lname FROM Customer WHERE customer_id = 5;
--show from id number 8
SELECT customer_id, cust_fname, cust_lname FROM Customer WHERE customer_id >= 8;
--return all data of customer_id between value 25 and 30, BETWEEN and AND KEYWORD
SELECT customer_id, cust_fname, cust_lname FROM Customer WHERE customer_id BETWEEN 25 AND 30;

--concat cr custom columns, combine together city and state separated with comma, temprary custom column
SELECT CONCAT(city, ',' , state_code) AS new_address FROM Addresses;
SELECT CONCAT(product_name, ',' , price_pg) AS price FROM Product;

--string fuctions apply to string and text
SELECT cust_fname, cust_lname, UPPER(cust_lname) FROM Customer;

--numeric functions, aggregate function, calculates average cost of all products together for price_pg
SELECT AVG(price_pg) FROM Product;

--sum() calculates all rows together, total quantity of products 
SELECT SUM(quantity) FROM Product;

--COUNT()
SELECT COUNT(quantity) FROM Order_item WHERE fk_order_id = 2;

--MAX()value
SELECT COUNT(*) AS item_cost, MAX(price_pg) AS max FROM Product;
--MIN
SELECT COUNT(*) AS item_cost, MIN(price_pg) AS min FROM Product;

--SUBQUERIES- query inside another query , first count avg then use value in another query, all items above 444 in order desc
SELECT AVG(price_pg) FROM Product;
SELECT product_name, price_pg FROM Product WHERE price_pg>444 ORDER BY price_pg DESC;
--or
SELECT product_name, price_pg FROM Product 
WHERE price_pg>(SELECT AVG(price_pg) FROM Product) 
ORDER BY price_pg DESC;
--join 2 tables customer and addresses
SELECT Customer.customer_id, Customer.cust_fname, Customer.cust_lname, Addresses.address_id, Addresses.address
FROM Customer, Addresses
WHERE Customer.customer_id = Addresses.address_id;

---
SELECT Manufacturer.manu_id, Manufacturer.manu_name, Product.product_id, Product.product_name
FROM Manufacturer, Product
WHERE Manufacturer.manu_id = Product.product_id;

----cross join table order_det and order_item
SELECT * FROM Order_det, Order_item;
--operates on two or more tables
SELECT * FROM  Order_item, Product, Customer;

SELECT * FROM  Order_item, Product, Customer
WHERE Order_item.fk_order_id= Product.product_id;

SELECT * FROM  Order_item, Product, Customer
WHERE Order_item.fk_order_id= Customer.customer_id;

--inner join
SELECT Order_det.order_id, Customer.cust_fname, Customer.cust_lname
FROM Order_det
INNER JOIN Customer ON Order_det.fk_customer_id = Customer.customer_id;

--left join
SELECT Customer.cust_fname, Customer.cust_lname, Order_det.order_id
FROM Customer
LEFT JOIN Order_det ON Customer.customer_id = Order_det.fk_customer_id
ORDER BY Customer.Cust_fname;
-- view
CREATE VIEW prod_price AS
SELECT product_name, price_pg
FROM Product
WHERE price_pg > (SELECT AVG(price_pg) FROM Product);

SELECT * FROM prod_price;

CREATE VIEW addresstview
AS SELECT  fk_customer_id, state_code
FROM Addresses
WHERE state_code='NJ';

SELECT * FROM addresstview;




----- stored procedure



DELIMITER $$

CREATE PROCEDURE list_above_avg_prod()
LANGUAGE SQL
DETERMINISTIC
SQL SECURITY DEFINER
COMMENT ' DISPLAY ABOVE AVG PRICE '
BEGIN
   CREATE TEMPORARY TABLE above_avg_prod
   AS
   SELECT DISTINCT product_name, price_pg
   FROM Product
   WHERE price_pg > (SELECT AVG(price_pg) FROM Product)
   ORDER BY price_pg;
   SELECT * FROM above_avg_prod;

END$$

