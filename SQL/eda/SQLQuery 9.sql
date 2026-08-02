use [Brazilian E_Commerce]
go

----------------------------subqueries---------------------------------
SELECT
    customer_id,
    total_spent
FROM
(
    SELECT
        o.customer_id,
        SUM(op.payment_value) AS total_spent
    FROM orders o
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY o.customer_id
) t
WHERE total_spent >
(
    SELECT AVG(total_spent)
    FROM
    (
        SELECT
            SUM(op.payment_value) AS total_spent
        FROM orders o
        JOIN order_payments op
            ON o.order_id = op.order_id
        GROUP BY o.customer_id
    ) x
);

-----------------------------------------------------------
select product_id , price
from order_items
where price >
(
select avg(price)
from order_items
)
-----------------------------------------------------------
SELECT
    seller_id,
    SUM(price) AS revenue
FROM order_items
GROUP BY seller_id
HAVING SUM(price) >
(
    SELECT AVG(revenue)
    FROM
    (
        SELECT SUM(price) AS revenue
        FROM order_items
        GROUP BY seller_id
    ) x
);
------------------------------------------------------------
SELECT
    order_id,
    SUM(price) AS order_value
FROM order_items
GROUP BY order_id
HAVING SUM(price) >
(
    SELECT AVG(order_total)
    FROM
    (
        SELECT
            SUM(price) AS order_total
        FROM order_items
        GROUP BY order_id
    ) x
);
-----------------------------CTEs------------------------------
WITH MonthlySales AS
(
SELECT
    YEAR(order_purchase_timestamp) AS year,
    MONTH(order_purchase_timestamp) AS month,
    SUM(payment_value) AS revenue
FROM orders o
JOIN order_payments p
ON o.order_id=p.order_id
GROUP BY
YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp)
)
SELECT *
FROM MonthlySales;
----------------------------------------------------------------
WITH CustomerSales AS
(
SELECT
o.customer_id,
SUM(op.payment_value) total_spent
FROM orders o
JOIN order_payments op
ON o.order_id=op.order_id
GROUP BY o.customer_id
)

SELECT TOP 10 *
FROM CustomerSales
ORDER BY total_spent DESC;
----------------------------------------------------------------
WITH CLV AS
(
SELECT
o.customer_id,
SUM(op.payment_value) lifetime_value
FROM orders o
JOIN order_payments op
ON o.order_id=op.order_id
GROUP BY o.customer_id
)

SELECT *
FROM CLV
ORDER BY lifetime_value DESC;
-----------------------------------------------------------------
with categorysales AS
(
select p.product_category_name,
sum (oi.price) revenue
from order_items oi
join products p
on oi.product_id = p.product_id
group by product_category_name
)
select *
from categorysales
------------------------------------------------------------------
SELECT *
FROM
(
SELECT
customer_id,
order_id,
order_purchase_timestamp,

ROW_NUMBER() OVER
(
PARTITION BY customer_id
ORDER BY order_purchase_timestamp DESC
) rn

FROM orders
)t

WHERE rn=1;
-------------------------------------------------------------------
SELECT
seller_id,
SUM(price) revenue,

RANK() OVER
(
ORDER BY SUM(price) DESC
) seller_rank

FROM order_items
GROUP BY seller_id
--------------------------------------------------------------------
SELECT
p.product_category_name,
SUM(oi.price) revenue,

DENSE_RANK() OVER
(
ORDER BY SUM(oi.price) DESC
) category_rank

FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id

GROUP BY p.product_category_name;
---------------------------------------------------------------------
WITH MonthlySales AS
(
SELECT
YEAR(o.order_purchase_timestamp) year,
MONTH(o.order_purchase_timestamp) month,
SUM(op.payment_value) revenue

FROM orders o
JOIN order_payments op
ON o.order_id=op.order_id

GROUP BY
YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp)
)

SELECT
year,
month,
revenue,

LAG(revenue)
OVER(ORDER BY year,month)
AS previous_month

FROM MonthlySales;
------------------------------------------------------------------
WITH MonthlySales AS
(
SELECT
YEAR(order_purchase_timestamp) year,
MONTH(order_purchase_timestamp) month,
SUM(payment_value) revenue

FROM orders o
JOIN order_payments p
ON o.order_id=p.order_id

GROUP BY
YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp)
)

SELECT
year,
month,
revenue,

LEAD(revenue)
OVER(ORDER BY year,month)
AS next_month

FROM MonthlySales;
------------------------------challenge---------------------------------------
WITH MonthlySales AS
(
SELECT
YEAR(o.order_purchase_timestamp) year,
MONTH(o.order_purchase_timestamp) month,
SUM(op.payment_value) revenue

FROM orders o
JOIN order_payments op
ON o.order_id=op.order_id

GROUP BY
YEAR(o.order_purchase_timestamp),
MONTH(o.order_purchase_timestamp)
)

SELECT

year,
month,
revenue,

LAG(revenue)
OVER(ORDER BY year,month)
AS previous_month,

revenue-
LAG(revenue)
OVER(ORDER BY year,month)
AS growth_amount,

ROUND(
100.0*
(
revenue-
LAG(revenue)
OVER(ORDER BY year,month)
)
/NULLIF(
LAG(revenue)
OVER(ORDER BY year,month),0)
,2)
AS growth_percentage,

RANK()
OVER(ORDER BY revenue DESC)
AS revenue_rank

FROM MonthlySales

ORDER BY year,month;