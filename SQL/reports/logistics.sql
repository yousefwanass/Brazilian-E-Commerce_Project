--------Average Delivery Time------------
SELECT
AVG(DATEDIFF(day,
order_purchase_timestamp,
order_delivered_customer_date))
AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;
-----------Delayed Deliveries--------------
SELECT
order_id,
order_estimated_delivery_date,
order_delivered_customer_date
FROM orders
WHERE order_delivered_customer_date >
order_estimated_delivery_date;
-------------Freight Cost Analysis----------------
SELECT
AVG(freight_value) AS avg_freight,
SUM(freight_value) AS total_freight
FROM order_items;