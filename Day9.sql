--ex1:
SELECT
SUM(
CASE
WHEN DEVICE_TYPE = 'tablet' OR DEVICE_TYPE = 'phone' THEN 1 
ELSE 0 
END) AS MOBILE_VIEWS,
SUM(
CASE
WHEN DEVICE_TYPE = 'laptop' THEN 1 
ELSE 0 END) AS LAPTOP_VIEWS
FROM VIEWERSHIP
--ex2:
select x, y, z,
case
when (x+y)>z and (x+z)>y and (y+z)>x then 'Yes'
else 'No'
end as triangle
from triangle
--ex3: bị lỗi
--ex4:
select name
from customer
where referee_id != 2 or referee_id is NULL
--ex5:
select survived, 
sum(case when pclass = 1 then 1 
else 0 end) as first_class,
sum(case when pclass = 2 then 1 
else 0 end) as second_class,
sum(case when pclass = 2 then 1 
else 0 end) as third_class
from titanic 
group by survived
