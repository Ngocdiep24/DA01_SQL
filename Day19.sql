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

