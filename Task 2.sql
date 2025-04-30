--2.1 customer with more then 1 order

SELECT customer_id, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;


--2.2 Customer with only 1 order

with customer_with_1_order_only as (
SELECT customer_id, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1
)
select COUNT(*) total_customer
from customer_with_1_order_only;

--2.3 Customer with only 2 order
with customer_with_2_order_only as (
SELECT customer_id, COUNT(order_id) AS total_orders
FROM customer_orders
GROUP BY customer_id
HAVING COUNT(order_id) = 2
)
select COUNT(*) total_customer
from customer_with_2_order_only


--2.4 new customer, returning customer by Month and Year

WITH first_orders AS  
(SELECT customer_id, MIN(order_date) AS first_order_date 
FROM customer_orders 
GROUP BY customer_id) 
SELECT 
year(o.order_date) AS month,
format(o.order_date, 'MM-yyyy') AS month_and_year, 
COUNT(DISTINCT CASE WHEN o.order_date = f.first_order_date THEN o.customer_id END) AS new_customers, 
COUNT(DISTINCT CASE WHEN o.order_date > f.first_order_date THEN o.customer_id END) AS repeating_customers 
FROM customer_orders as o 
JOIN first_orders f ON o.customer_id = f.customer_id 
GROUP BY year(o.order_date), format(o.order_date, 'MM-yyyy')
ORDER BY year(o.order_date), format(o.order_date, 'MM-yyyy')


