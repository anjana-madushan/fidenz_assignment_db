show databases;
SELECT CURRENT_USER();
SET ROLE 'reporting_role'@'localhost';

SELECT name, price FROM shop4Alldb.product; 
select count(product_id) as 'Total No of Products' from shop4Alldb.product;

INSERT INTO shop4Alldb.product(name, description, price) VALUES("Azus vivobook 15","",350000);