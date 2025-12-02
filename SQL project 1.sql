
-- create a new database
create database sales_analysis_project_one;
-- create a table
show databases;
use sales_analysis_project_one;
DROP TABLE IF EXISTS sales_transactions;

CREATE TABLE sales_transactions (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
select*from sales_transactions
limit 10;
select count(*) from sales_transactions;
select*from sales_transactions
where 
transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
customer_id is null
or 
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or
cogs is null
or 
total_sale is null;
-- Data Exploration
-- How many sales we have?
select count(*) as total_sale from sales_transactions;
-- How many customers we have?
select count(customer_id) as total_sale from sales_transactions;
-- How many distinct customer we have?
select count(distinct customer_id) as total_sale from sales_transactions;

-- Data Analysis and Business Key Problem and Answer
-- Write a sql query to retrive all columns for sales made on '2022-11-05'( Answer :11)
select* from sales_transactions
where sale_date ='2022-11-05';
select count(*) from sales_transactions
where sale_date='2022-11-05';

-- Write a SQL category to retrive all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov 22 ( Clothing 1780,sum qyt 134)
select
category,
sum(quantity)
from sales_transactions
where category='clothing'
group by 1;

SELECT category, SUM(quantity)
from sales_transactions
where category = 'clothing'
and DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
GROUP BY category;

-- Write a sql query to calculate the total sales ( total_sale) for each category( Beauty-286790,clothing 30995, electronics 31145)
select
category,
sum(total_sale) as net_sale
from sales_transactions
group by 1;

-- Write a sql querry to find the average age of each customer who purchased the item of beauty category
select
round(avg(age),2) as avg_age
from sales_transactions
where category='Beauty';

-- write a sql querry to find all transactions where the total_sale is greater than 1000
select* from sales_transactions
where total_sale>1000;
-- Write a SQL querry to find out the total number of transaction made by each  gender in each category.
select
category,
gender,
count(*) as total_trans
from sales_transactions
group by
category,
gender
order by 1;
-- Write a SQL querry to calculate the average_sale for each month. Find out the selling month on each year
WITH monthly_avg AS (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale),2) AS average_sale
    FROM sales_transactions
    GROUP BY year, month
)
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY year ORDER BY average_sale DESC) AS rk
    FROM monthly_avg
) AS ranked_months
WHERE rk = 1;

-- Write a SQL querry to find out the top five customer based on the highest total sale

select customer_id, SUM(total_sale) as total_sales
from sales_transactions
group by customer_id
order by total_sales desc
limit 5;
-- Write a sql querry to find out the unique customer who purchased from each category
select
category,
count(distinct customer_id) as unique_customer
from sales_transactions
group by category;

-- Write a sql querry to create each shift and number of orders.

SELECT 
    CASE
        WHEN sale_time BETWEEN '06:00:00' AND '14:00:00' THEN 'Morning'
        WHEN sale_time BETWEEN '14:00:01' AND '22:00:00' THEN 'Evening'
        ELSE 'Night'
    END AS shift,
    COUNT(*) AS total_orders
FROM sales_transactions
GROUP BY shift;
-- End of Project--


























