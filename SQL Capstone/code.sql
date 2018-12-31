SELECT question,
COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY 2;

SELECT question,
COUNT(DISTINCT user_id)
 FROM survey
 GROUP BY 2;

SELECT DISTINCT
	q.user_id, 
	h.number_of_pairs IS NOT NULL
	AS is_home_try_on,
	h.number_of_pairs,
	p.user_id IS NOT NULL
	AS is_purchase
FROM quiz q
LEFT JOIN home_try_on h
	ON q.user_id = h.user_id
LEFT JOIN purchase p
	ON p.user_id = q.user_id
LIMIT 10;

WITH funnel AS (
  SELECT DISTINCT
	q.user_id, 
	h.number_of_pairs IS NOT NULL
	AS is_home_try_on,
	h.number_of_pairs,
	p.user_id IS NOT NULL
	AS is_purchase
FROM quiz q
LEFT JOIN home_try_on h
	ON q.user_id = h.user_id
LEFT JOIN purchase p
	ON p.user_id = q.user_id)
SELECT SUM(is_purchase) AS purchases, number_of_pairs, COUNT(user_id) AS tryons, ROUND(1.0 * SUM(is_purchase) / COUNT(user_id), 2) AS hit_rate
FROM funnel
GROUP BY 2
HAVING SUM(is_purchase) > 0;

SELECT COUNT(user_id) AS hits, model_name, 1.0 * price * COUNT(user_id) AS revenue, price, style, color
FROM purchase
GROUP BY 2, 6
ORDER BY 3 DESC;

SELECT user_id, COUNT(DISTINCT product_id)
FROM purchase
GROUP BY 1
ORDER BY 1 DESC
LIMIT 5;
