-- CREATE DATABASE Retail_Sales;
-- USE Retail_Sales;
-- show databases
-- USE Retail_Sales;
-- CREATE TABLE retail_sales (
-- transactions_id	 INT PRIMARY KEY,
-- sale_time date,
-- customer_id time,
-- gender varchar (15),
-- age	int,
-- category varchar (15),
-- quantiy	INT,
-- price_per_unit FLOAT,
-- cogs FLOAT,
-- total_sale FLOAT
-- );

-- UPDATE retail_sales
-- SET age = 41
-- WHERE age IS NULL;

-- select * from retail_sales
-- where age is null;

-- update age from retail_sales
-- where age is null as 41;

SELECT * FROM retail_sales.retail_sales
where
transactions_id	 is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age	is null
or
category is null
or
quantiy	is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null
order by transactions_id;

delete  from retail_sales
where quantiy is null;

SELECT AVG(age) AS avg_male_age
FROM retail_sales
WHERE gender = 'Male' AND age IS NOT NULL;

SELECT AVG(age) AS avg_female_age
FROM retail_sales
WHERE gender = 'Female' AND age IS NOT NULL;

# https://github.com/najirh/Retail-Sales-Analysis-SQL-Project--P1/blob/main/README.md  (questions)

select hour(curtime());

select count(distinct category) from retail_sales;

select distinct category from retail_sales;

select min(age), max(age), avg(age) from retail_sales;
select min(price_per_unit), max(price_per_unit), avg(price_per_unit) from retail_sales;

select * from retail_sales
where sale_date= '22-11-05';

select *  from retail_sales
where category='clothing';

SELECT * 
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
    AND
    quantity >= 4;
    
select category, sum(total_sale), count(*) as total_order from retail_sales
group by category;

select round(avg(age)) from retail_sales
where category="beauty";

select category, gender ,count(*) as total_transactions from retail_sales
group by
category, gender
order by category;

select year(sale_date), 
month(sale_date),
round(avg(total_sale)),
sum(total_sale),
rank() over(partition by year(sale_date) order by round(avg(total_sale)) asc )
from retail_sales
group by year(sale_date), month(sale_date);
#order by 1,2  asc;

SELECT *
FROM (
    SELECT 
        YEAR(sale_date) AS sale_year, 
        MONTH(sale_date) AS sale_month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        SUM(total_sale) AS total_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date) 
            ORDER BY ROUND(AVG(total_sale), 2) ASC
        ) AS `rank`
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS T1
WHERE `rank` = 1;

# top 5 transactions
select * from retail_sales
order by total_sale desc
 limit 5;

# top 5 customers

select 
 customer_id,
 sum(total_sale)
 from retail_sales
 group by customer_id 
 order by sum(total_sale) desc
 limit 5
 ;
 
 select 
 category,
 count(customer_id),
 count(distinct customer_id) as 'unique customers'
 from retail_sales
 group by category;
 
 # Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 
 select *,
 Case 
      when hour(sale_time)<12 then 'Morning'
       when 12<= hour(sale_time)<=17 then 'Afternoon'
        when hour(sale_time)>17 then 'Evening'
End as shift
from retail_sales;

SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) >= 12 AND HOUR(sale_time) <= 17 THEN 'Afternoon'
        WHEN HOUR(sale_time) > 17 THEN 'Evening'
    END AS shift,
    COUNT(*) AS order_count
FROM retail_sales
GROUP BY shift
ORDER BY order_count DESC;
