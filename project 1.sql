CREATE DATABASE E_commerce;


CREATE TABLE customer(
cust_id INT PRIMARY KEY,
name1 VARCHAR(255),
gender CHAR(1),
DOB DATE,
city VARCHAR(255),
pwd VARCHAR(255),
email VARCHAR(255),
DeliveryAddress VARCHAR(255),
contacts VARCHAR(255),
currentorders VARCHAR(255),
previousorders VARCHAR(255),
paymentdetails VARCHAR(255),
sell_id INT REFERENCES seller(sell_id)
);

CREATE TABLE seller(
Sell_id INT PRIMARY KEY,
Sell_name VARCHAR(255),
mobileno INT,
password1 VARCHAR(255),
date_of_productdelivery VARCHAR(255)
);

INSERT INTO customer VALUES(1000,'Nikhil','M','1991-11-02','shirpur','abc','nikhil@gmail.com','23 shingave shirpur','232323','t-shirt','hoody','phone_pay',2001),
                             (1001,'ajay','M','1990-02-03','pune','abc','ajay@gmail.com','hadapsar pune','232323','t-shirt','hoody','G-pay',2010),
                              (1002,'vijay','M','1991-04-19','mumbai','abc','vijay@gmail.com','borivali mumbai','232323','t-shirt','hoody','amazon-pay',2002),
                               (1003,'amir','M','1999-10-08','hydrabad','abc','amir@gmail.com','hydrabad','232323','t-shirt','hoody','paytm',2003);
SELECT*FROM customer;

INSERT INTO seller VALUES(2001,'akashy',8982323,'abc','10-12-2023'),
(2010,'john',69479898,'xyzp','10-12-2023'),
(2002,'akash',1459765,'a0077','10-12-2023'),
(2003,'abdul',9765142,'abjak','10-12-2023');

SELECT * FROM seller;

CREATE TABLE orders(
order_id INT PRIMARY KEY,
o_status VARCHAR(255),
Deliveydate DATE,
cust_id INT  REFERENCES customer(cust_id) 
);

INSERT INTO orders VALUES (1,'completed','2022-11-11',1000),
                          (2,'pending','2022-02-12',1001),
                          (3,'paid','2022-09-13',1002),
                          (4,'completed','2022-10-03',1003);

INSERT INTO orders VALUES (5,'delivered','2021-10-25',1000),
(6,'delivered','2022-10-15',1001),
(7,'delivered','2022-11-25',1001),
(8,'delivered','2022-08-05',1000);
                          
DROP TABLE orders

SELECT * FROM orders;

CREATE TABLE Coupon_code(
c_id INT PRIMARY KEY,
percentage_discount INT,
prod_id INT REFERENCES product(prod_id) 
);

SELECT * FROM Coupon_code;

CREATE TABLE product(
prod_id INT PRIMARY KEY,
name1 VARCHAR(255),
color VARCHAR(255),
sellorname VARCHAR(255),
Sizesav VARCHAR(255),
quantityav INT,
cost INT,
discount INT,
pstatus VARCHAR(255),
rating INT,
isonsale CHAR(1),
categories VARCHAR(255),
brands VARCHAR(255),
images VARCHAR(255),
questions VARCHAR(255),
cust_id INT REFERENCES customer(cust_id),
order_id INT REFERENCES orders(order_id)
);

INSERT INTO product VALUES(3000,'Formal_shirt','blue','akashy','xl',4,230,20,'available',4,'y','mens','xyz','xyz1','questions',1000,1),
                          (3001,'jeans','black','john','32',5,750,20,'available',4,'y','mens','xyz','xyz1','questions',1001,2),
                          (3002,'T-shirt','white','akash','xl',6,330,20,'available',4,'y','mens','xyz','xyz1','questions',1002,3),
                          (3003,'hoody','red','abdul','xxl',8,630,20,'available',4,'y','mens','xyz','xyz1','questions',1003,4);
SELECT*FROM product;                          

CREATE TABLE review(
rev_id INT PRIMARY KEY,
rating VARCHAR(255),
cust_id INT REFERENCES customer(cust_id)
 );


CREATE TABLE replacement (
rep_id INT PRIMARY KEY,
productname VARCHAR(255),
o_status VARCHAR(255)
);

CREATE TABLE Wishlist(
wish_id INT PRIMARY KEY,
productname VARCHAR(255),
product_price INT,
prod_id_wish INT REFERENCES product(prod_id),
cust_id INT REFERENCES customer(cust_id)
);

CREATE TABLE ordershipmentinvoices(
invoice_id INT PRIMARY KEY,
productname VARCHAR(255),
GST INT,
totalRupee INT,
modeofpayament VARCHAR(255),

prod_id INT REFERENCES product(prod_id),
cust_id INT REFERENCES customer(cust_id)
);


INSERT INTO ordershipmentinvoices VALUES(240,'Formal_shirt',142,10010,'phone_pay',3000,1000),
(241,'jeans',142,20010,'G-pay',3001,1001);

--Task 3

--1
SELECT * FROM customer ORDER BY city;

--2
ALTER TABLE product RENAME COLUMN name1 TO prod_name;
ALTER TABLE product RENAME COLUMN color TO prod_color;
ALTER TABLE product RENAME COLUMN sellorname TO prod_sellername;
ALTER TABLE product RENAME COLUMN Sizesav TO prod_Sizes_av;
ALTER TABLE product RENAME COLUMN quantityav TO prod_quantityav;
ALTER TABLE product RENAME COLUMN cost TO prod_cost;
ALTER TABLE product RENAME COLUMN discount TO prod_discount;
ALTER TABLE product RENAME COLUMN pstatus TO prod_pstatus;
ALTER TABLE product RENAME COLUMN categories TO prod_categories;
ALTER TABLE product RENAME COLUMN brands TO prod_brands;
ALTER TABLE product RENAME COLUMN images TO prod_images;
ALTER TABLE product RENAME COLUMN questions TO prod_questions;
ALTER TABLE product RENAME COLUMN cust_id TO prod_cust_id;
ALTER TABLE product RENAME COLUMN order_id TO prod_order_id;

--3
SELECT c.name1,c.gender,c.DOB,c.email,c.currentorders FROM customer c INNER JOIN product p ON c.`cust_id`=p.`prod_cust_id`;
--4
SELECT c.name1,c.gender,c.DOB,c.email,c.currentorders FROM customer c JOIN product p ON c.`cust_id`=p.`prod_cust_id`
WHERE c.`name1`='A%A' ;

--5
SELECT c.name1,c.gender,c.DOB,c.email,c.previousorders FROM customer c INNER JOIN ordershipmentinvoices o ON c.`cust_id`=o.`cust_id` 
WHERE o.totalRupee>10000 AND COUNT(c.cust_id)>1;

--6
USE e_commerce;
DELIMITER $$
CREATE PROCEDURE `e_commerce`.run()
BEGIN

CREATE TABLE customer(
cust_id INT PRIMARY KEY,
name1 VARCHAR(255),
gender CHAR(1),
DOB DATE,
city VARCHAR(255),
pwd VARCHAR(255),
email VARCHAR(255),
DeliveryAddress VARCHAR(255),
contacts VARCHAR(255),
currentorders VARCHAR(255),
previousorders VARCHAR(255),
paymentdetails VARCHAR(255),
sell_id INT REFERENCES seller(sell_id)
);

CREATE TABLE seller(
Sell_id INT PRIMARY KEY,
Sell_name VARCHAR(255),
mobileno INT,
password1 VARCHAR(255),
date_of_productdelivery VARCHAR(255)
);

CREATE TABLE Coupon_code(
c_id INT PRIMARY KEY,
percentage_discount INT,
prod_id INT REFERENCES product(prod_id) 
);

CREATE TABLE orders(
order_id INT PRIMARY KEY,
o_status VARCHAR(255),
Deliveydate DATE,
cust_id INT  REFERENCES customer(cust_id) 
);

CREATE TABLE product(
prod_id INT PRIMARY KEY,
name1 VARCHAR(255),
color VARCHAR(255),
sellorname VARCHAR(255),
Sizesav VARCHAR(255),
quantityav INT,
cost INT,
discount INT,
pstatus VARCHAR(255),
rating INT,
isonsale CHAR(1),
categories VARCHAR(255),
brands VARCHAR(255),
images VARCHAR(255),
questions VARCHAR(255),
cust_id INT REFERENCES customer(cust_id),
order_id INT REFERENCES orders(order_id)
);

CREATE TABLE review(
rev_id INT PRIMARY KEY,
rating VARCHAR(255),
cust_id INT REFERENCES customer(cust_id)
 );

CREATE TABLE replacement (
rep_id INT PRIMARY KEY,
productname VARCHAR(255),
o_status VARCHAR(255)
);

CREATE TABLE Wishlist(
wish_id INT PRIMARY KEY,
productname VARCHAR(255),
product_price INT,
prod_id_wish INT REFERENCES product(prod_id),
cust_id INT REFERENCES customer(cust_id)
);

CREATE TABLE ordershipmentinvoices(
invoice_id INT PRIMARY KEY,
productname VARCHAR(255),
GST INT,
totalRupee INT,
modeofpayament VARCHAR(255),
prod_id INT REFERENCES product(prod_id),
cust_id INT REFERENCES customer(cust_id)
);

END$$
DELIMITER;

CALL run;