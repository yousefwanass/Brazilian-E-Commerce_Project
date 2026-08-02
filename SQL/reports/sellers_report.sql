------------Top Sellers-------------
SELECT TOP 20
seller_id,
SUM(price) AS revenue
FROM order_items
GROUP BY seller_id
ORDER BY revenue DESC;
-----------------Seller Revenue-----------
SELECT
seller_id,
SUM(price) AS revenue
FROM order_items
GROUP BY seller_id;
------------------Seller Ranking--------------
SELECT
seller_id,
SUM(price) AS revenue,
RANK() OVER(
ORDER BY SUM(price) DESC
) AS seller_rank
FROM order_items
GROUP BY seller_id;
