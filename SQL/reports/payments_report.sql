----------Payment Type Distribution-------------
SELECT
payment_type,
COUNT(*) AS total
FROM order_payments
GROUP BY payment_type;
-----------Average Payment Value-----------
SELECT
AVG(payment_value) AS average_payment
FROM order_payments;