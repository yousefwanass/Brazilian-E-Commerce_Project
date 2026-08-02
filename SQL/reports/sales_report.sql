
-----------Total Revenue---------------
SELECT
SUM(payment_value) AS total_revenue
FROM order_payments;


---------Monthly Revenue---------------
SELECT
YEAR(o.order_purchase_timestamp) AS year,
MONTH(o.order_purchase_timestamp) AS month,
SUM(op.payment_value) AS revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY
YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp)
ORDER BY year, month;
---------------Daily Revenue----------
SELECT
CAST(order_purchase_timestamp AS DATE) AS order_date,
SUM(payment_value) AS revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY CAST(order_purchase_timestamp AS DATE)
ORDER BY order_date;
-------------Average Order Value--------------
SELECT
AVG(payment_value) AS average_order_value
FROM order_payments;