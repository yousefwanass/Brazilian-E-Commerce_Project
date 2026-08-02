select COUNT(customer_id) as number_of_customers_per_state , customer_state
from customers
group by customer_state


SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    order_year,
    order_month;

select AVG(payment_value) as avg_payment_value
from order_payments

select sum(payment_value) as Total_revenue
from order_payments

SELECT AVG(freight_value) AS avg_freight_cost
FROM order_items

select SUM(payment_value) as total_revenue , payment_type
from order_payments
group by payment_type;

select count(order_id) as total_orders , order_status
from orders
group by order_status;

select top 10 customer_city as top_cities_by_number_of_customers ,count(customer_id) as total_customers
from customers
group by customer_city
order by total_customers desc

select count(customer_id) as number_of_customers , customer_state
from customers
group by customer_state
having count(customer_id) > 1000
order by number_of_customers desc

SELECT seller_id,COUNT(order_id) AS total_sales
FROM order_items
GROUP BY seller_id
HAVING COUNT(order_id) > 300
ORDER BY total_sales DESC;