---SQL retail sales analysis 
create database retail_sales


--create table
create table retail_sales_tb
   (
	          transactions_id int primary key,
			  sale_date date,	
			  sale_time time,
			  customer_id int,
			  gender varchar(10),
			  age int,
			  category varchar(15),
			  quantity int, 
			  price_per_unit float,
			  cogs	float,
			  total_sale float
);
 ---checking NULL values(DATA CLEANING)
select * from retail_sales_tb
where transactions_id is null;

select * from retail_sales_tb
where sale_time is null;

select * from retail_sales_tb
where 
      customer_id is null
	  or
	  transactions_id is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or 
	  gender is null
	  or
	  category is null
	  or
	  quantity is null
	  or
	  cogs is null
	  or
	  total_sale is null;
	  
	  delete from retail_sales_tb
	  where 
      customer_id is null
	  or
	  transactions_id is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or 
	  gender is null
	  or
	  category is null
	  or
	  quantity is null
	  or
	  cogs is null
	  or
	  total_sale is null;
	  
	  select count(*)
	  from 
	  retail_sales_tb
	  
	  ---DATA EXPLORATION 
	  -- HOW MANY SALES WE HAVE?
	  SELECT COUNT(*) AS TOTAL_SALE FROM RETAIL_SALES_TB
	  
	  --- HOW MANY UNIQUE CUSTOMERS WE HAVE?
	  SELECT COUNT( DISTINCT CUSTOMER_ID) AS TOTAL_SALE FROM RETAIL_SALES_TB
	  
	  ---HOW MANY UNIQUE CATEGORY WE HAVE?
	  SELECT COUNT(DISTINCT CATEGORY) FROM RETAIL_SALES_TB
	  
	  ---BUSINESS KEY PROBLEMS:
 --1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'
	  SELECT * 
	  FROM RETAIL_SALES_TB
	  WHERE SALE_DATE = '2022-11-05'
	  
--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM RETAIL_SALES_TB
WHERE CATEGORY = 'Clothing' AND TO_CHAR(SALE_DATE,'YYYY-MM')='2022-11'
AND 
QUANTITY >= 4;

--3.Write a SQL query to calculate the total sales (total_sale) for each category.
select category, 
sum(total_sale)as net_sale
from retail_sales_tb
group by 1

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
Round (avg(age),2) as avg_age
from retail_sales_tb
where category = 'Beauty'

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
select 
transactions_id as transactions
from retail_sales_tb
where total_sale >1000

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
        category,
		gender,
		count(*)as total_no_trans
		from retail_sales_tb
		group by category,
		gender
	  
--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select 
      year,
	  month,
	  avg_sale
from
(
select
       Extract(year from sale_date)as year,
	   Extract(month from sale_date)as month,
	   avg(total_sale)as avg_sale,
	   rank()over (partition by Extract(year from sale_date)order by  avg(total_sale) desc)as rank
	   from retail_sales_tb
	   group by 1,2 
	)as t1
	where rank = 1


--8.Write a SQL query to find the top 5 customers based on the highest total sales
select 
customer_id,
sum(total_sale)as highest_sale
from retail_sales_tb
group by 1
order by 2 desc
limit 5


--9.Write a SQL query to find the number of unique customers who purchased items from each category.
select 
category,
count(distinct (customer_id)) as unique_customer
from retail_sales_tb
group by category


--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales_tb
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
	  
	  
----END OF PROJECT	  
	  
	  
	  
	  
	  
	  








