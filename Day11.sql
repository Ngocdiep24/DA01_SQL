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
