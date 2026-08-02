use [Brazilian E_Commerce]
go

------------------joins_from_day_7-----------------------
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING SUM(oi.price) > 1000000
ORDER BY total_revenue DESC;
---------------------------------------------------------
SELECT
    c.customer_city,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_city
HAVING COUNT(o.order_id) > 500
ORDER BY total_orders DESC;
---------------------------------------------------------
SELECT
    c.customer_state,
    AVG(DATEDIFF(DAY,
        o.order_purchase_timestamp,
        o.order_delivered_customer_date)) AS avg_delivery_days
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_delivery_days DESC;
----------------------------------------------------------
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;


--day8--
---------------------Inner_Joins--------------------------
SELECT
    o.order_id,
    o.order_status,
    c.customer_id,
    c.customer_city,
    c.customer_state
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;
--------------------------------------------------

SELECT
    o.order_id,
    o.order_status,
    p.payment_type,
    p.payment_value
FROM orders o
INNER JOIN order_payments p
ON o.order_id = p.order_id;
--------------------------------------------------

SELECT
    o.order_id,
    oi.product_id,
    p.product_category_name
FROM orders o
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id;

-------------------Left_Join-------------------------
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT COUNT(*)
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
-------------------------------------------
SELECT
    p.product_id,
    p.product_category_name
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
-------------------------------------------
SELECT
    s.seller_id,
    s.seller_city
FROM sellers s
LEFT JOIN order_items oi
    ON s.seller_id = oi.seller_id
WHERE oi.seller_id IS NULL;
---------------Right_Joins-------------------
SELECT
    oi.order_id,
    s.seller_id,
    s.seller_city
FROM order_items oi
RIGHT JOIN sellers s
    ON oi.seller_id = s.seller_id;
--------------Full_Outer_join----------------
SELECT
    c.customer_id,
    o.order_id
FROM customers c
FULL OUTER JOIN orders o
    ON c.customer_id = o.customer_id;
---------------Multi_table_join--------------
SELECT
    c.customer_id,
    c.customer_city,
    p.product_category_name AS product,
    COUNT(oi.product_id) AS quantity,
    pay.payment_type,
    SUM(pay.payment_value) AS total_payment
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN order_payments pay
    ON o.order_id = pay.order_id
GROUP BY
    c.customer_id,
    c.customer_city,
    p.product_category_name,
    pay.payment_type
ORDER BY
    c.customer_id;
----------------Chanllenge--------------------
SELECT
    o.order_id,
    o.order_purchase_timestamp AS order_date,
    o.order_status,

    c.customer_id,
    c.customer_city,
    c.customer_state,

    s.seller_id,
    s.seller_city,
    s.seller_state,

    p.product_id,
    p.product_category_name,

    oi.price,
    oi.freight_value,

    pay.payment_type,
    pay.payment_installments,
    pay.payment_value

FROM orders o

INNER JOIN customers c
    ON o.customer_id = c.customer_id

INNER JOIN order_items oi
    ON o.order_id = oi.order_id

INNER JOIN products p
    ON oi.product_id = p.product_id

INNER JOIN sellers s
    ON oi.seller_id = s.seller_id

INNER JOIN order_payments pay
    ON o.order_id = pay.order_id

ORDER BY o.order_purchase_timestamp DESC;