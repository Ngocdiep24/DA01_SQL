--ex1
ALTER TABLE public.sales_dataset_rfm_prj 
ALTER COLUMN ordernumber TYPE int USING (ordernumber::int),
ALTER COLUMN quantityordered TYPE int USING (quantityordered::integer),
ALTER COLUMN priceeach TYPE numeric USING (priceeach::numeric),
ALTER COLUMN orderlinenumber TYPE int USING (orderlinenumber::int),
ALTER COLUMN sales TYPE numeric USING (sales::numeric),
ALTER COLUMN orderdate TYPE date USING (orderdate::date),
ALTER COLUMN status TYPE text USING (status::text),
ALTER COLUMN productline TYPE text USING (productline::text),
ALTER COLUMN msrp TYPE int USING (msrp::int),
ALTER COLUMN productcode TYPE text USING (productcode::text),
ALTER COLUMN customername TYPE text USING (customername::text),
ALTER COLUMN phone TYPE text USING (phone::text),
ALTER COLUMN addressline1 TYPE text USING (addressline1::text),
ALTER COLUMN addressline2 TYPE text USING (addressline2::text),
ALTER COLUMN city TYPE text USING (city::text),
ALTER COLUMN state TYPE text USING (state::text),
ALTER COLUMN postalcode TYPE text USING (postalcode::text),
ALTER COLUMN country TYPE text USING (country::text),
ALTER COLUMN territory TYPE text USING (territory::text),
ALTER COLUMN contactfullname TYPE text USING (contactfullname::text),
ALTER COLUMN dealsize TYPE text USING (dealsize::text)
--ex2
SELECT ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE 
FROM public.sales_dataset_rfm_prj
WHERE ORDERNUMBER IS NULL OR 
QUANTITYORDERED IS NULL OR
PRICEEACH IS NULL OR
ORDERLINENUMBER IS NULL or
SALES IS NULL or
ORDERDATE is null
--ex3
alter table public.sales_dataset_rfm_prj
add column CONTACTLASTNAME varchar,
add column CONTACTFIRSTNAME varchar;
alter table public.sales_dataset_rfm_prj
alter column CONTACTLASTNAME TYPE text USING (CONTACTLASTNAME::text),
alter column CONTACTFIRSTNAME TYPE text USING (CONTACTFIRSTNAME::text)
--ex4
with cte as
(select ordernumber,
extract (quarter from orderdate) as QTR_ID,
extract (month from orderdate) as MONTH_ID,
extract (year from orderdate) as YEAR_ID
from public.sales_dataset_rfm_prj_clean)
select * from public.sales_dataset_rfm_prj_clean as a
join cte as b
on a.ordernumber=b.ordernumber
--ex5
--boxplot
with cte as(
select Q1*1.5-IQR as min_value,
Q3*1.5-IQR as max_value
from((select 
percentile_cont (0.25) within group (order by QUANTITYORDERED) as Q1,
percentile_cont (0.75) within group (order by QUANTITYORDERED) as Q3,
percentile_cont (0.75) within group (order by QUANTITYORDERED) - percentile_cont (0.25) within group (order by QUANTITYORDERED) as IQR
from public.sales_dataset_rfm_prj)) as a)
select * from public.sales_dataset_rfm_prj
where QUANTITYORDERED< (select min_value from cte)
or QUANTITYORDERED> (select max_value from cte)
--Z_score
with cte as
(select ordernumber, QUANTITYORDERED,
(select avg (QUANTITYORDERED) from public.sales_dataset_rfm_prj) as avg,
(select stddev (QUANTITYORDERED) from public.sales_dataset_rfm_prj) as stddev
from public.sales_dataset_rfm_prj)
select ordernumber, (QUANTITYORDERED-avg)/stddev as z_score
from cte
where abs((QUANTITYORDERED-avg)/stddev)>2
--xu ly du lieu
update public.sales_dataset_rfm_prj
set QUANTITYORDERED= (select avg(QUANTITYORDERED) from public.sales_dataset_rfm_prj)
where QUANTITYORDERED in (select QUANTITYORDERED from outlier)
--ex6
ALTER TABLE sales_dataset_rfm_prj
  RENAME TO SALES_DATASET_RFM_PRJ_CLEAN
