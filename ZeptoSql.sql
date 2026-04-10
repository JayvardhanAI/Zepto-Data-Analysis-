CREATE DATABASE ZeptoSql;
use ZeptoSql;

-- sample data

SELECT * FROM zepto_v2_utf8
LIMIT 10;

-- sku_id Added 

ALTER TABLE zepto_v2_utf8
ADD COLUMN sku_id INT AUTO_INCREMENT PRIMARY KEY;

-- null values

SELECT * FROM zepto_v2_utf8
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
availableQuantity IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- different product categories
SELECT DISTINCT category
FROM zepto_v2_utf8
ORDER BY category;

-- products in stock vs out of stock

SELECT outOfStock , COUNT(*)
FROM zepto_v2_utf8
GROUP BY outOfStock;

-- product names present more than multipletimes

SELECT name , COUNT(*) 
FROM zepto_v2_utf8
GROUP BY name
HAVING COUNT(*) > 1;

SELECT mrp , discountedSellingPrice FROM zepto_v2_utf8;

 -- find the top 10 best  value products on discoute percentage. 
 
SELECT DISTINCT name,mrp, discountPercent
FROM zepto_v2_utf8
ORDER BY discountPercent DESC;

-- what are the products with high mrp but outOfStock.

SELECT DISTINCT name, mrp
FROM zepto_v2_utf8
WHERE outOfStock = 'true'
ORDER BY mrp DESC;

-- calculate estimated revenue for each category

SELECT category, SUM(discountedSellingPrice * quantity) AS estimated_revenue
FROM zepto_v2_utf8
GROUP BY category
ORDER BY estimated_revenue DESC;

-- find all products where mrp is greater than 500 and discount is less than 10%

SELECT name, MAX(mrp) AS mrp, MIN(discountPercent) AS discountPercent
FROM zepto_v2_utf8
WHERE mrp > 500 AND discountPercent < 10
GROUP BY name
ORDER BY mrp DESC;

-- identify top 5 categories offering highest average discounts percentage 

SELECT category, AVG(discountPercent) AS avg_discount
FROM zepto_v2_utf8
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- find the price per gram for products above 100gm and sort by best value

SELECT name,
       MIN(discountedSellingPrice / weightInGms) AS price_per_gram
FROM zepto_v2_utf8
WHERE weightInGms > 100
GROUP BY name
ORDER BY price_per_gram ASC;

-- group the products into categories like low , medium , bulk

SELECT name,
       weightInGms,
       CASE 
           WHEN weightInGms < 500 THEN 'low'
           WHEN weightInGms BETWEEN 500 AND 1000 THEN 'medium'
           ELSE 'bulk'
       END AS category_size
FROM zepto_v2_utf8
ORDER BY 
    CASE 
        WHEN weightInGms < 500 THEN 1
        WHEN weightInGms BETWEEN 500 AND 1000 THEN 2
        ELSE 3
    END,
    weightInGms ASC;

-- what is the total inventory weight per category
 
 SELECT category,
       SUM(weightInGms * quantity) AS total_inventory_weight
FROM zepto_v2_utf8
GROUP BY category
ORDER BY total_inventory_weight DESC; 














