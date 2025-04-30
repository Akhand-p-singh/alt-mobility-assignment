-- 3.1 Payment Status
SELECT payment_status, COUNT(*) AS count, ROUND(AVG(payment_amount),2) AS avg_amount
FROM payments
GROUP BY payment_status;


-- 3.2 Payment Method Distribution and Payment Status with Payment Success Rates
SELECT 
    p.payment_method,
    COUNT(*) AS payment_count,
    SUM(CASE WHEN p.payment_status = 'completed' THEN 1 ELSE 0 END) AS successful_payments,
	SUM(CASE WHEN p.payment_status = 'failed' THEN 1 ELSE 0 END) AS failed_payments,
	SUM(CASE WHEN p.payment_status = 'pending' THEN 1 ELSE 0 END) AS pending_payments,
    CAST(ROUND(SUM(CASE WHEN p.payment_status = 'completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS DECIMAL(10, 2)
) AS payment_success_rate
FROM payments p
GROUP BY p.payment_method
ORDER BY payment_success_rate DESC;


-- 3.3 Monthly failed vs. successful payments

SELECT
  FORMAT(payment_date, 'yyyy-MM') AS month,
  SUM(CASE WHEN payment_status = 'failed' THEN 1 ELSE 0 END) AS failed_count,
  SUM(CASE WHEN payment_status = 'completed' THEN 1 ELSE 0 END) AS success_count
FROM payments
GROUP BY FORMAT(payment_date, 'yyyy-MM')
ORDER BY month;




