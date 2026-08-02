USE [Brazilian E_Commerce];
GO

SELECT 'customers' AS TableName, COUNT(*) AS [RowCount] FROM customers
UNION ALL SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL SELECT 'product_category_name_translation', COUNT(*) FROM product_category_name_translation
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL SELECT 'order_reviews', COUNT(*) FROM order_reviews;

select * 
from customers

select customer_unique_id , customer_city
from customers;

SELECT customer_unique_id
FROM customers
WHERE customer_city = 'sao paulo';

select *
from orders;

SELECT order_id
FROM orders
WHERE order_delivered_carrier_date >= '2018-01-01';

SELECT order_id
FROM orders
ORDER BY order_purchase_timestamp;


SELECT DISTINCT customer_state
FROM customers;

SELECT *
FROM orders
WHERE order_status = 'delivered';


SELECT *
FROM customers
WHERE LOWER(customer_city) = 'rio de janeiro';

SELECT TOP 20 *
FROM orders
ORDER BY order_purchase_timestamp DESC;

## challenge

select TOP 20 order_id
from orders
where order_status='delivered'
ORDER BY order_delivered_customer_date DESC;