create database Shop4AllDB;
show databases;

use Shop4AllDB;

-- create table
create table Product(
product_id bigint unsigned NOT NULL AUTO_INCREMENT,
name varchar(100) NOT NULL,
description varchar(255),
price decimal(10, 2) NOT NULL,
constraint PK_Product PRIMARY KEY (product_id),
constraint UC_Product_Name UNIQUE (name)
);

create table Category(
category_id int unsigned NOT NULL AUTO_INCREMENT,
name varchar(50) NOT NULL,
constraint PK_Category PRIMARY KEY (category_id),
constraint UC_Category UNIQUE (name)
);

create table Product_Category(
product_id bigint unsigned NOT NULL,
category_id int unsigned NOT NULL,
constraint PK_Product_Category PRIMARY KEY (product_id, category_id),
constraint FK_Product_Category_Product FOREIGN KEY (product_id) references Product(product_id) on update cascade on delete cascade,
constraint FK_Product_Category_Category FOREIGN KEY (category_id) references Category(category_id) on update cascade on delete cascade
);

create table Inventory(
product_id bigint unsigned NOT NULL,
quantity_in_stock int unsigned NOT NULL check (quantity_in_stock > 0),
constraint PK_Inventory PRIMARY KEY (product_id),
constraint FK_Inventory FOREIGN KEY (product_id) references Product(product_id) on update cascade on delete cascade
);

create table Customer(
customer_id binary(16) NOT NULL,
name varchar(100) NOT NULL,
email varchar(40) NOT NULL,
phone varchar(20) NOT NULL,
constraint PK_Customer PRIMARY KEY (customer_id),
constraint UC_Customer_Email UNIQUE (email),
constraint UC_Customer_Phone UNIQUE (phone)
);

create table Postal_Code(
postal_code VARCHAR(20),
country VARCHAR(50) NOT NULL,
city VARCHAR(50) NOT NULL,
state_province VARCHAR(50),
constraint PK_Postal_Code PRIMARY KEY (postal_code)
);

create table Shipping_Address(
address_id binary(16) NOT NULL,
street_address varchar(50) NOT NULL,
postal_code varchar(20) NOT NULL,
constraint PK_Shipping_Address PRIMARY KEY (address_id),
constraint FK_Shipping_Address FOREIGN KEY (postal_code) REFERENCES Postal_Code(postal_code)on update cascade on delete cascade
);

create table Customer_Shipping_Address(
customer_shipping_id binary(16) NOT NULL,
customer_id binary(16) NOT NULL,
address_id binary(16) NOT NULL,
constraint PK_Cust_Ship_Address PRIMARY KEY (customer_shipping_id),
constraint FK_Cust_Ship_Address_Customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)on update cascade on delete cascade,
constraint FK_Cust_Ship_Address_Address FOREIGN KEY (address_id) REFERENCES Shipping_Address(address_id)on update cascade on delete cascade
);

create table Orders(
order_id binary(16) NOT NULL,
customer_shipping_id binary(16) NOT NULL,
order_date date NOT NULL,
total_price decimal(10,2),
constraint PK_Orders PRIMARY KEY (order_id),
constraint FK_Orders FOREIGN KEY (customer_shipping_id) references Customer_Shipping_Address(customer_shipping_id) on update cascade on delete restrict
);

create table Order_Item(
order_id binary(16) NOT NULL,
product_id bigint unsigned NOT NULL,
quantity int NOT NULL check (quantity>0),
unit_price decimal(10, 2) NOT NULL,
constraint PK_Order_Product PRIMARY KEY (order_id, product_id),
constraint FK_Order_Product_Order FOREIGN KEY (order_id) references Orders(order_id) on update cascade on delete cascade,
constraint FK_Order_Product_Product FOREIGN KEY (product_id) references Product(product_id) on update cascade on delete restrict
);

show tables from Shop4AllDB;
select * from orders;

-- Insert Data 
insert into product(name, description, price) values ("Dell Inspiron IB 3530 Laptop", "13th Gen I7, 8GB RAM, 512GB SSD, 15.6 Display (Silver)",  310999), 
("Usha Room Heater", "Usha Room Heater 423/8/2T", 22500), 
("Symphony Air Cooler - DiET 12i", "Diet 12i functions on as little as 80 watts of power. It performs silently without a hush with its blower delivering better cooling and a powerful air throw.", 38000), 
("ASUS Zenbook S 14 UX5406SA-PZ365WS Laptop", "ASUS Zenbook S 14 UX5406SA-PZ365WS - 14th Gen Ultra 7, 32GB RAM, 1TB, Touch Screen, OLED, Scandinavian White", 659999);

insert into Inventory values (1, 25), (2, 8), (3, 15), (4, 18);

insert into Category(name) values ("Electronics"), ("Kitchen"), ("BedRoom"), ("Digital"), ("Office");
insert into Product_Category values (1, 1), (1, 4), (2, 3), (2, 1), (3, 1), (3, 3), (4, 1), (4, 4);

insert into Customer values 
(UUID_TO_BIN(UUID()), "Anjana Pasindu", "pbapmadushan123@gmail.com", "+94762974568"),
(UUID_TO_BIN(UUID()), "John Doe", "johnDoe@gmail.com", "+94762574568"),
(UUID_TO_BIN(UUID()), "Kane", "kane@gmail.com", "+11752974568"),
(UUID_TO_BIN(UUID()), "jane", "jane23@gmail.com", "+0252874568"),
(UUID_TO_BIN(UUID()), "Bobby Singer", "booby123@gmail.com", "+45761114568");

insert into Postal_Code values 
('12345', "Sri Lanka", "Kottawa", "Western"),
('31000', "Sri Lanka", "Trincomalee", "Eastern"),
('10115', "Sri Lanka", "Malabe", "Western"),
('75462', "United States", "Paris", "Texas"),
('1011 AB', "Nederland", "Amsterdam", ""), 
('2678 CZ', "Nederland", "De Lier", "");

insert into Shipping_Address values 
(UUID_TO_BIN(UUID()), "Hospital Road", "12345"),
(UUID_TO_BIN(UUID()), "3rd Lane", "10115"),
(UUID_TO_BIN(UUID()), "Park Lane", "31000"),
(UUID_TO_BIN(UUID()), "Nz Avenue", "75462"),
(UUID_TO_BIN(UUID()), "Train Avenue", "75462"),
(UUID_TO_BIN(UUID()), "Dht Lane", "1011 AB"),
(UUID_TO_BIN(UUID()), "Cmsar Avenue", "2678 CZ");

insert into Customer_Shipping_Address values 
(UUID_TO_BIN(UUID()), UUID_TO_BIN("4d9c8af0-8948-11f0-8a3d-fc4482c7c571"), UUID_TO_BIN("63a87a22-894b-11f0-8a3d-fc4482c7c571")),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("4d9c8af0-8948-11f0-8a3d-fc4482c7c571"), UUID_TO_BIN("63a89d99-894b-11f0-8a3d-fc4482c7c571")),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("4d9c8af0-8948-11f0-8a3d-fc4482c7c571"), UUID_TO_BIN("63a89ff7-894b-11f0-8a3d-fc4482c7c571")),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("4d9cb215-8948-11f0-8a3d-fc4482c7c571"), UUID_TO_BIN("63a8a0c8-894b-11f0-8a3d-fc4482c7c571")),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("4d9cb30d-8948-11f0-8a3d-fc4482c7c571"), UUID_TO_BIN("63a8a164-894b-11f0-8a3d-fc4482c7c571")),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("4d9cb3a2-8948-11f0-8a3d-fc4482c7c571"), UUID_TO_BIN("63a8a2af-894b-11f0-8a3d-fc4482c7c571")),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("4d9cb426-8948-11f0-8a3d-fc4482c7c571"), UUID_TO_BIN("63a8a20f-894b-11f0-8a3d-fc4482c7c571"));


insert into Orders values 
(UUID_TO_BIN(UUID()), UUID_TO_BIN("1812fd92-894d-11f0-8a3d-fc4482c7c571"), "2025-05-25", 310999),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("181366d4-894d-11f0-8a3d-fc4482c7c571"), "2025-05-25", 310999),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("181366d4-894d-11f0-8a3d-fc4482c7c571"), "2025-05-26", 45000),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("18136912-894d-11f0-8a3d-fc4482c7c571"), "2025-07-21", 60500),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("18136a35-894d-11f0-8a3d-fc4482c7c571"), "2025-08-01", 310999),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("18136af8-894d-11f0-8a3d-fc4482c7c571"), "2025-09-04", 659999),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("18136ba0-894d-11f0-8a3d-fc4482c7c571"), "2025-07-25", 22500),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("18136c6f-894d-11f0-8a3d-fc4482c7c571"), "2025-06-02", 76000),
(UUID_TO_BIN(UUID()), UUID_TO_BIN("18136c6f-894d-11f0-8a3d-fc4482c7c571"), "2025-06-08", 659999);

insert into Order_Item values 
(UUID_TO_BIN("f4e44908-894f-11f0-8a3d-fc4482c7c571"), 1, 1, 310999),
(UUID_TO_BIN("f4e521da-894f-11f0-8a3d-fc4482c7c571"), 1, 1, 310999),
(UUID_TO_BIN("f4e52a72-894f-11f0-8a3d-fc4482c7c571"), 2, 2, 22500),
(UUID_TO_BIN("f4e52b7a-894f-11f0-8a3d-fc4482c7c571"), 2, 1, 22500),
(UUID_TO_BIN("f4e52b7a-894f-11f0-8a3d-fc4482c7c571"), 3, 1, 38000),
(UUID_TO_BIN("f4e52be3-894f-11f0-8a3d-fc4482c7c571"), 1, 1, 310999),
(UUID_TO_BIN("f4e52c3b-894f-11f0-8a3d-fc4482c7c571"), 4, 1, 659999),
(UUID_TO_BIN("f4e52ca6-894f-11f0-8a3d-fc4482c7c571"), 2, 1, 22500),
(UUID_TO_BIN("f4e52d02-894f-11f0-8a3d-fc4482c7c571"), 3, 2, 38000),
(UUID_TO_BIN("f4e52d70-894f-11f0-8a3d-fc4482c7c571"), 4, 1, 659999);

select BIN_TO_UUID(order_id), total_price from orders;
select * from product;

SELECT BIN_TO_UUID(customer_id), name FROM customer;
SELECT BIN_TO_UUID(address_id), street_address FROM Shipping_Address;
SELECT BIN_TO_UUID(customer_shipping_id) FROM Customer_Shipping_Address;

-- VIEWS
-- view to get specific order details -- 
create or replace view top_selling_products as
SELECT p.product_id, p.name, p.description, sum(oi.quantity) as 'Total No of Units Sold'
FROM product p
JOIN order_item oi ON p.product_id = oi.product_id
Group By p.product_id
ORDER BY sum(oi.quantity) DESC;

select * from top_selling_products;

-- Functions
-- average price of product within a specific category
DELIMITER //
create function avg_price_of_a_category(category_id int)
Returns decimal(10, 2)
not deterministic
reads sql data
begin
	declare result decimal(10, 2);
	select avg(p.price) into result
	from Product p
	Join Product_Category pc on pc.product_id = p.product_id
	Join Category c on c.category_id = pc.category_id
	where c.category_id = category_id;
	return result;
end;
//
DELIMITER ;

select avg_price_of_a_category(1);

-- Database Procedures
-- Monthly sales report
DELIMITER //
create procedure getMonthlyReport()
begin
	select sum(oi.unit_price*oi.quantity) as `Total Revenue`, sum(oi.quantity) as `Total units sold per month`, year(o.order_date) as `Year`, month(o.order_date) as `Month`
	from order_item oi
	join orders o on o.order_id = oi.order_id
    join product p on p.product_id = oi.product_id
	group by year(o.order_date), month(o.order_date)
    order by year(o.order_date), month(o.order_date);
end;
//
DELIMITER ;

CALL getMonthlyReport();

show indexes from order_item;

-- Roles Creation -- 
create role 'primary_role'@'localhost';
create role 'reporting_role'@'localhost';
create role 'inventory_manager_role'@'localhost';
create role 'order_manager_role'@'localhost';

-- Granting Permissions to Roles -- 

-- primary roles only can have  select, insert, update all the databases
grant select, insert, update on shop4Alldb.*
to 'primary_role'@'localhost';

-- reporting roles only can have select and retrive all the data from the databases
grant select on shop4Alldb.*
to 'reporting_role'@'localhost';

-- inventory roles only can execute crud operations to the product and inventory tables
grant select, update, insert, delete on shop4Alldb.product 
to 'inventory_manager_role'@'localhost';
grant select, update, insert, delete on shop4Alldb.Inventory 
to 'inventory_manager_role'@'localhost';

-- order_manager_role roles only can execute crud operations to the order and order item tables
grant select, update, insert, delete on shop4Alldb.orders 
to 'order_manager_role'@'localhost';
grant select, update, insert, delete on shop4Alldb.order_item
to 'order_manager_role'@'localhost';

-- creating users
create user 'primary_user_1'@'localhost' identified by 'primary123@#';
create user 'reporting_user_1'@'localhost' identified by 'reporter123@#';
create user 'inventory_manager_user_1'@'localhost' identified by 'inventory123@#';
create user 'order_manager_1'@'localhost' identified by 'order123@#';

-- Assigning roles to users 
grant 'primary_role'@'localhost' to 'primary_user_1'@'localhost';
grant 'reporting_role'@'localhost' to 'reporting_user_1'@'localhost';
grant 'inventory_manager_role'@'localhost' to 'inventory_manager_user_1'@'localhost';
grant 'order_manager_role'@'localhost' to 'order_manager_1'@'localhost';

SELECT User, Host FROM mysql.user;
SHOW GRANTS FOR 'primary_user_1'@'localhost';

-- Transactions

-- adding a new product 
START TRANSACTION;

insert into product(name, description, price) values ("Midea Kitchen Machine 600W - MJ-KM6001W", "Stainless Steel Mixing Bowl (4L SUS bowl for CE version)", 29999);

set @productId = LAST_INSERT_ID();

insert into inventory(product_id, quantity_in_stock) values (@productId, 10); 
insert into Product_Category(product_id, category_id) values (@productId, 1);
insert into Product_Category(product_id, category_id) values (@productId, 2);

COMMIT;

-- creating a new order
START TRANSACTION;

set @order_id = UUID_TO_BIN(UUID());

insert into orders (order_id, customer_shipping_id, date, total_price) values (@order_id, UUID_TO_BIN("18136a35-894d-11f0-8a3d-fc4482c7c571"), "2025-05-25", 1349497);

insert into order_item values 
(1, @order_id, 2, 310999),
(2, @order_id, 3, 22500),
(4, @order_id, 1, 659999);

update inventory set quantity_in_stock = quantity_in_stock - 2 where product_id = 1;
update inventory set quantity_in_stock = quantity_in_stock - 3 where product_id = 2;
update inventory set quantity_in_stock = quantity_in_stock - 1 where product_id = 4;

COMMIT;

-- adding a shipping address for existing user
START TRANSACTION;

set @shipping_address_id = UUID_TO_BIN(UUID());
set @customer_shipping_address_id = UUID_TO_BIN(UUID());
set @postal_code = '12045';

insert into postal_code(postal_code, country, city, state_province) values (@postal_code, "Sri Lanka", "Dopme road", "");
insert into shipping_address(address_id, street_address, postal_code) values (@shipping_address_id, 'Wennappuwa', @postal_code);
insert into Customer_Shipping_Address(customer_shipping_id, customer_id, address_id) values (@customer_shipping_address_id, UUID_TO_BIN("4d9c8af0-8948-11f0-8a3d-fc4482c7c571"), @shipping_address_id);

COMMIT;

select * from product;select * from inventory;
select * from Product_Category;
select * from Category;
select * from inventory;
select BIN_TO_UUID(customer_id), name from customer;
select * from Postal_Code;
select * from Shipping_Address;
select * from Customer_Shipping_Address;
select BIN_TO_UUID(customer_shipping_id), BIN_TO_UUID(customer_id) from Customer_Shipping_Address;
select * from orders;
select * from order_item;

SELECT User, Host FROM mysql.user;