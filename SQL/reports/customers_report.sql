-------------Top 20 Customers--------------
SELECT TOP 20
o.customer_id,
SUM(op.payment_value) AS total_spent
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC;
-----------------Customer Lifetime Value---------------
SELECT
o.customer_id,
COUNT(DISTINCT o.order_id) AS orders,
SUM(op.payment_value) AS lifetime_value
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY o.customer_id;
-------------------Customers by State-----------------------
SELECT
customer_state,
COUNT(customer_id) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;
-----------------Repeat Customers---------------------
SELECT
customer_id,
COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >1;
