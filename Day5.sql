--ex1:
select distinct city from station
where id%2 = 0 
--ex2:
select count(city) - count(distinct city) from station
--ex3:
--ex4:
SELECT
ROUND (cast(sum(item_count*order_occurrences)/sum(order_occurrences) as decimal),1) as mean
FROM items_per_order
--ex5:
SELECT candidate_id FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
having count (skill) = 3; 
--ex6:
SELECT
  user_id,
date(MAX(post_date)) - date (MIN(post_date)) as days_between
FROM posts
where post_date >= '2021-01-01'and post_date < '2022-01-01'
group by
  user_id
having count (post_id) >= 2
--ex7:
SELECT card_name,
MAX(issued_amount)-min(issued_amount) as difference
FROM monthly_cards_issued
group by card_name
order by card_name DESC
--ex8:
SELECT manufacturer,
count (drug) as drug_count,
ABS (sum(cogs-total_sales)) as total_loss
FROM pharmacy_sales
where total_sales < cogs
group by manufacturer
order by total_loss desc 
--ex9:
select * from Cinema
where id%2=1 and description <> 'boring'
order by rating desc
--ex10:
select teacher_id, 
COUNT (DISTINCT subject_id) AS cnt
from Teacher
group by teacher_id
--ex11:
select user_id,
count(follower_id) as followers_count
from followers
group by user_id
order by user_id 
--ex12:
select class
from courses
group by class
having count (student) >=5
