--ex1
WITH so_luong AS (
SELECT company_id, title, description, 
COUNT(job_id) AS so_luong_job
FROM job_listings
GROUP BY company_id, title, description
)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM so_luong
WHERE so_luong_job > 1
--ex2
with spend as (
select category, product, sum(spend) as total_spend from product_spend
where EXTRACT(year from transaction_date)=2022
GROUP BY category, product
ORDER BY SUM(spend) DESC LIMIT 4)
SELECT category, product, total_spend 
FROM spend
ORDER BY category
--ex3
with count_call AS
(SELECT policy_holder_id, COUNT(case_id) FROM callers
GROUP BY policy_holder_id
having count(case_id)>=3) 
select COUNT(policy_holder_id) as policy_holder_count from count_call
--ex4
SELECT 
pages.page_id
FROM pages
LEFT JOIN page_likes
on page_likes.page_id=pages.page_id
where page_likes.liked_date is null
ORDER BY page_id
--ex5
with current_month as 
(select user_id,event_type,event_date
from user_actions
where extract(month from event_date)= 7 
and event_type in ('sign-in','like','comment')),
previous_month as 
(select user_id,event_type,event_date
from user_actions
where extract(month from event_date)= 6
and event_type in ('sign-in','like','comment'))
select 
extract(month from a.event_date) as mth,
count(distinct a.user_id) as total_active_users
from current_month a 
join previous_month b
on a.event_type = b.event_type and a.user_id = b.user_id
group by mth
--ex6
SELECT TO_CHAR(trans_date, 'YYYY-MM') AS month, country,
COUNT(*) AS trans_count, 
COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count,
SUM(amount) AS trans_total_amount,
SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY TO_CHAR(trans_date, 'YYYY-MM'), country
--ex7
with cte as 
(select p.product_id, min(year) first_year 
from sales as s join product p 
on s.product_id = p.product_id 
group by p.product_id)
select s1.product_id, cte.first_year, s1.quantity, s1.price 
from sales as s1 join cte
on s1.product_id=cte.product_id 
and s1.year = cte.first_year
--ex8
WITH cte AS(
SELECT customer_id,
COUNT(product_key) AS product
FROM Customer
GROUP BY customer_id)
SELECT customer_id
FROM cte
WHERE product = (
SELECT COUNT(DISTINCT product_key)
FROM Product)
--ex9
SELECT t1.employee_id
FROM employees t1
LEFT JOIN employees t2 ON t1.manager_id = t2.employee_id
WHERE t1.salary < 30000 AND (t1.manager_id IS NOT NULL AND t2.employee_id IS NULL)
ORDER BY employee_id
--ex10
WITH so_luong AS (
SELECT company_id, title, description, 
COUNT(job_id) AS so_luong_job
FROM job_listings
GROUP BY company_id, title, description
)
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM so_luong
WHERE so_luong_job > 1
--ex11
WITH person as (
select b.name as results
from movierating a
join users b on a.user_id = b.user_id
group by b.name
order by count(b.name) desc, b.name asc
limit 1),
movie as (
select b.title as results
from movierating a
join movies b on a.movie_id = b.movie_id and (a.created_at between '2020-02-01' and '2020-02-29')
group by b.title
order by avg(a.rating) desc, b.title asc
limit 1)
select * from person
union 
select * from movie
--ex12
with cte as(
select requester_id as id, count(accepter_id) as num
from RequestAccepted
group by requester_id
union all
select accepter_id id, count(requester_id) as num
from RequestAccepted
group by accepter_id)
select id, sum(num) as num from cte group by id
order by sum(num) desc 
limit 1
