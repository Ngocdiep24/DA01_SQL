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
ROW_NUMBER() OVER (
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
