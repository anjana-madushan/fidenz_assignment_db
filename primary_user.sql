set role 'primary_role'@'localhost';
show databases;
use shop4alldb;

select * from category;

START TRANSACTION;

insert into product(name, description, price) values ("Azus vivobook 15","",350000);

set @productId = LAST_INSERT_ID();

insert into inventory(product_id, quantity_in_stock) values (@productId, 10); 
insert into Product_Category(product_id, category_id) values (@productId, 1);
insert into Product_Category(product_id, category_id) values (@productId, 4);

COMMIT;

select * from product;
select * from inventory;

update inventory set  quantity_in_stock = 15 where product_id = 9;

delete from category where category_id = 6;