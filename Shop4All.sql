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