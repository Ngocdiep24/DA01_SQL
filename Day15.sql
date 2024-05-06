--ex1
with cte as(
SELECT 
EXTRACT(year from transaction_date) as year,
product_id,
spend as curr_year_spend,
lag(spend) over (PARTITION BY product_id ORDER BY transaction_date) as prev_year_spend 
from user_transactions)
select year, product_id, curr_year_spend, prev_year_spend,
ROUND((100*((curr_year_spend-prev_year_spend)/prev_year_spend)),2) as yoy_rate
from cte
--ex2
with cte as
(SELECT card_name,issued_amount,
row_number() OVER(PARTITION BY card_name order by issued_amount	) as ranking
from monthly_cards_issued)
select card_name, issued_amount
from cte
where ranking=1
order by issued_amount DESC
--ex3
with cte AS
(SELECT *,
row_number() OVER (
PARTITION BY user_id ORDER BY transaction_date) AS row
FROM transactions)
select 
user_id, spend, transaction_date
from cte
where row=3
--ex4
with cte as
(select *,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date desc) as ranking
from user_transactions) 
select transaction_date, user_id, COUNT(product_id) from cte 
where ranking=1
GROUP BY transaction_date, user_id
order by transaction_date
--ex5
WITH cte AS (
SELECT user_id, tweet_date, tweet_count,
LAG(tweet_count, 2) OVER (PARTITION BY user_id ORDER BY tweet_date) AS lag2,
LAG(tweet_count, 1) OVER (PARTITION BY user_id ORDER BY tweet_date) AS lag1
FROM tweets)
SELECT user_id, tweet_date,
CASE 
WHEN lag1 IS NULL AND lag2 IS NULL THEN ROUND(tweet_count, 2)
WHEN lag1 IS NULL THEN ROUND((lag2 + tweet_count) / 2.0, 2)
WHEN lag2 IS NULL THEN ROUND((lag1 + tweet_count) / 2.0, 2)
ELSE ROUND((lag1 + lag2 + tweet_count) / 3.0, 2)
END AS rolling_avg_3d
FROM cte
--ex6
with cte AS
(SELECT 
transaction_id, merchant_id, credit_card_id, amount, 
transaction_timestamp-lag(transaction_timestamp) over( PARTITION BY merchant_id, credit_card_id, amount order by transaction_timestamp ) as time
FROM transactions)
select count(*) as payment_count
from cte
where time <= '00:10:00'
--ex7
SELECT category, product, total_spend FROM (
select category, product, sum(spend) as total_spend,
rank() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as ranking
from product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product) as T
where ranking <=2
ORDER BY category, ranking
--ex8
with cte as (
select a.artist_name,
Dense_Rank() over (ORDER BY COUNT(s.song_id) DESC) as ranking
from global_song_rank as gsk
inner join songs s on gsk.song_id=s.song_id
inner join artists a on a.artist_id=s.artist_id
where gsk.rank<=10
group by a.artist_name)
select cte.artist_name, cte.ranking as artist_rank
from cte
where cte.ranking<=5
