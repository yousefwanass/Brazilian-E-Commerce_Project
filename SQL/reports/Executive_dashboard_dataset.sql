SELECT

o.order_purchase_timestamp AS order_date,
o.order_delivered_customer_date,

c.customer_id,
c.customer_city,
c.customer_state,

oi.product_id,
p.product_category_name,

oi.seller_id,

COUNT(oi.product_id) OVER(PARTITION BY oi.order_id) AS quantity,

op.payment_value,

oi.freight_value,

oi.price AS revenue

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

JOIN order_items oi
ON o.order_id = oi.order_id

JOIN products p
ON oi.product_id = p.product_id

JOIN order_payments op
ON o.order_id = op.order_id;