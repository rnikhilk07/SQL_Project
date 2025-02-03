--Q3.3

WITH RECURSIVE
  customter_with_country AS (
     SELECT customer. customer_id, first_name, last_name,billing_country,SUM(total) AS total_spending
     FROM invoice
	 JOIN customer ON customer. customer_id = invoice. customer_id
     GROUP BY 1,2,3,4
     ORDER BY 2,3 DESC),

  country_max_spending AS(
     SELECT billing_country,MAX(total_spending) AS max_spending
     FROM customter_with_country
     GROUP BY billing_country)
	 
SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customter_with_country cc
JOIN country_max_spending ms 
ON cc.billing_country = ms.billing_country
WHERE cc. total_spending = ms.max_spending
ORDER BY 1;