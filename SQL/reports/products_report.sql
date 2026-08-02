--------Top 20 Products----------
SELECT TOP 20
product_id,
COUNT(*) AS sales
FROM order_items
GROUP BY product_id
ORDER BY sales DESC;
----------Lowest Selling Products----------
SELECT TOP 20
product_id,
COUNT(*) AS sales
FROM order_items
GROUP BY product_id
ORDER BY sales;
-----------Revenue by Category----------------
SELECT
p.product_category_name,
SUM(oi.price) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC;