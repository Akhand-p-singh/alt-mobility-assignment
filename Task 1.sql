select * from customer_orders
select * from payments


--1.1  Order Status with total order and percentage

WITH cte AS (
    SELECT order_status, COUNT(order_id) AS total_order
    FROM customer_orders
    GROUP BY order_status
)
SELECT 
    order_status, 
    total_order, 
    ROUND(CAST(total_order AS FLOAT) * 100.0 / (SELECT COUNT(*) FROM customer_orders), 2) AS percentage
FROM cte;


--1.2 Yearly trend of total order and sales

select year(order_date) as Year,COUNT(order_id) AS total_orders, Round(SUM(order_amount),2) total_sales
from customer_orders
group by year(order_date)
order by Year


--1.3  Average order amount year by year

select YEAR(order_date) Year, round(AVG(order_amount),2) avg_order_amount
from customer_orders
group by YEAR(order_date)
order by YEAR(order_date)