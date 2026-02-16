drop table if exists zepto

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent Numeric(5,2),
availableQuantity INTEGER,
discountedSellingPrice Numeric(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

-- Data Exploration

--count rows
SELECT COUNT(*) FROM zepto;

--sample data
SELECT * FROM zepto
LIMIT 10;

--NULL VALUES
SELECT * FROM zepto
WHERE name ISNULL
OR
category ISNULL
OR
mrp ISNULL
OR
discountPercent  ISNULL
OR
discountedSellingPrice  ISNULL
OR
weightInGms ISNULL
OR
availableQuantity ISNULL
OR
outOfStock ISNULL
OR
quantity ISNULL;

--DIFFERENT PRODUCT CATEGORIES
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- PRODUCTS IN STOCK VS OUT OF STOCK;
SELECT outOfStock, COUNT(sku_id)
FROM zepto
GROUP BY outOfStock;

-- PRODUCTS NAME PRESENT MULTIPLE TIMES
SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY count(sku_id) DESC;

--DATA CLEANING

--PRODUCTS WITH PRICE = 0
SELECT * FROM ZEPTO
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp=0;

--CONVERT PAISE TO RUPEES
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT mrp, discountedSellingPrice FROM zepto;

--- 1. Top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- 2.What are the Products with High MRP but Out of Stock
SELECT DISTINCT name, mrp 
FROM zepto 
WHERE outOfStock = TRUE and mrp > 300
ORDER BY mrp DESC;

-- 3. Calculate Estimated Revenue For each category
SELECT category,
SUM (discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY category 
ORDER BY total_revenue;

-- 4. Find all Products where MRP is greater than 500 and discount is less than 10% 
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- 5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent), 2) AS avg_discount 
FROM zepto
GROUP BY category 
ORDER BY avg_discount DESC
LIMIT 5;

-- 6. Find the Price per gram for products above 100g and sort_by best value 
SELECT DISTINCT name, weightInGMs, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGMs,2) AS price_per_gram
FROM zepto 
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- 7. Group the Products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
      WHEN weightInGms < 5000 THEN 'Medium'
	  ELSE 'Bulk'
	  END AS weight_category
FROM zepto;

-- 8. What is the total inventory weight per category
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto 
GROUP BY category
ORDER BY total_weight;



