---views---
create view customer_summary as
select customer_state , count (customer_id) total_customers
from customers
group by customer_state;

select * 
from customer_summary
---------------------------------------------------------------
create view sales_summary as
select order_id ,
    sum (price) total_sales,
    sum (freight_value) total_frieght
from order_items
group by order_id 

select * 
from sales_summary
---------------------------------------------------------------
create view products_summary as
select
   p.product_category_name,
   count(*) total_products
from products p
group by p.product_category_name

select * 
from products_summary
----------------------------------------------------------------
CREATE VIEW RevenueByCategory AS
SELECT
    p.product_category_name,
    SUM(oi.price) revenue
FROM order_items oi
JOIN products p
ON oi.product_id=p.product_id

GROUP BY p.product_category_name;

select * 
from RevenueByCategory
----------------------------------------------------------------
CREATE VIEW MonthlySales AS
SELECT

YEAR(order_purchase_timestamp) year,
MONTH(order_purchase_timestamp) month,

SUM(payment_value) revenue

FROM orders o
JOIN order_payments p

ON o.order_id=p.order_id

GROUP BY

YEAR(order_purchase_timestamp),
MONTH(order_purchase_timestamp);

select * 
from MonthlySales
------------------------------stored_procedures-------------------------------------
CREATE PROCEDURE GetCustomerSales
@CustomerID VARCHAR(50)

AS

BEGIN

SELECT

o.customer_id,

SUM(op.payment_value) total_sales

FROM orders o

JOIN order_payments op

ON o.order_id=op.order_id

WHERE o.customer_id=@CustomerID

GROUP BY o.customer_id

END;

exec GetCustomerSales 
'00046a560d407e99b969756e0b10f282';
-------------------------------------------------------------------
CREATE PROCEDURE GetMonthlyRevenue
@Year INT

AS

BEGIN

SELECT

MONTH(order_purchase_timestamp) month,

SUM(payment_value) revenue

FROM orders o

JOIN order_payments p

ON o.order_id=p.order_id

WHERE YEAR(order_purchase_timestamp)=@Year

GROUP BY MONTH(order_purchase_timestamp)
order by MONTH(order_purchase_timestamp) desc
END;

exec GetMonthlyRevenue
2017;
-------------------------------------------------------------
CREATE PROCEDURE GetTopProducts
AS

BEGIN

SELECT TOP 10

product_id,

COUNT(*) sales

FROM order_items

GROUP BY product_id

ORDER BY sales DESC

END;

exec GetTopProducts
-------------------------------------------------------------------
CREATE PROCEDURE GetCategorySales

AS

BEGIN

SELECT

p.product_category_name,

SUM(oi.price) revenue

FROM order_items oi

JOIN products p

ON oi.product_id=p.product_id

GROUP BY p.product_category_name

END;

exec GetCategorySales
---------------------------dynamic_SQL------------------------------------
DECLARE @State VARCHAR(2)

SET @State='MG'

DECLARE @SQL NVARCHAR(MAX)

SET @SQL='

SELECT *

FROM customers

WHERE customer_state='''+@State+''''

EXEC sp_executesql @SQL;
----------------------------------------------------------------------------
DECLARE @Category NVARCHAR(100)

SET @Category='cama_mesa_banho'

DECLARE @SQL1 NVARCHAR(MAX)

SET @SQL1='

SELECT *

FROM products p

JOIN product_category_name_translation t

ON p.product_category_name=t.product_category_name

WHERE p.product_category_name='''+@Category+''''

EXEC sp_executesql @SQL1;
---------------------------------------------------------------------------
DECLARE @Year INT

SET @Year=2018

DECLARE @SQL2 NVARCHAR(MAX)

SET @SQL2='

SELECT *

FROM orders

WHERE YEAR(order_purchase_timestamp)='
+CAST(@Year AS VARCHAR)

EXEC sp_executesql @SQL2;