--ex1:
SELECT Country.Continent, FLOOR(AVG(City.Population))
FROM Country, City 
WHERE Country.Code = City.CountryCode 
GROUP BY Country.Continent ;
--ex2:
SELECT 
ROUND(1.0*SUM(CASE WHEN signup_action = 'Confirmed' THEN 1 ELSE 0 END)/
(count(signup_action)),2)
FROM emails
inner join texts
on emails.email_id=texts.email_id
--ex4:
SELECT CUSTOMER_ID 
FROM CUSTOMER_CONTRACTS 
inner JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID= CUSTOMER_CONTRACTS.PRODUCT_ID
GROUP BY CUSTOMER_ID 
HAVING COUNT(DISTINCT PRODUCT_CATEGORY) >=3
--ex5:
select emp.reports_to as employee_id,
mng.name,
count(emp.reports_to) as reports_count,
round(avg(emp.age),0) as average_age
from employees emp
join employees mng
on emp.reports_to=mng.employee_id
group by emp.reports_to, mng.name
order by emp.reports_to
--ex6:
select Products.product_name, sum(Orders.unit) as unit from Products
inner join Orders
on Orders.product_id =Products.product_id
where Orders.order_date between '2020-02-01' and '2020-02-29'
group by Products.product_name
having sum(Orders.unit) >= 100
--ex7:
SELECT 
pages.page_id
FROM pages
LEFT JOIN page_likes
on page_likes.page_id=pages.page_id
where page_likes.liked_date is null
ORDER BY page_id
--bai tap 1:
select distinct
min(replacement_cost) as min_replacement_cost
from public.film
--bai tap 2:
select
case
when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost between 20.00 and 24.99 then 'medium'
else 'high'
end as replacement,
count('*') as so_luong
from public.film
group by replacement
--bai tap 3:
select a.name , max(length) as max_length
from public.category as a
inner join public.film_category as b on a.category_id=b.category_id
inner join public.film as c on b.film_id=c.film_id
where a.name in ('Drama', 'Sports')
group by a.name
--bai tap 4:
select a.name,
count(*) as category
from public.category as a
inner join public.film_category as b on a.category_id=b.category_id
inner join public.film as c on b.film_id=c.film_id
group by a.name
order by category desc
limit 1
--bai tap 5:
select a.first_name, a.last_name, count(b.film_id) as so_luong from public.actor as a
join public.film_actor as b on a.actor_id=b.actor_id
group by a.first_name, a.last_name
order by so_luong desc
limit 1

