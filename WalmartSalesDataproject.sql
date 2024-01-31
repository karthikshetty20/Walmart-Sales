CREATE DATABASE IF NOT EXISTS WalmartSales;

CREATE TABLE IF NOT EXISTS Sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
	branch VARCHAR(5) NOT NULL,
	city VARCHAR(30) NOT NULL,
	customer_type VARCHAR(30) NOT NULL,
	gender VARCHAR(10) NOT NULL,
	product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
	quantity INT NOT NULL,
	VAT FLOAT(6, 4) NOT NULL,
	total DECIMAL(12, 4) NOT NULL,
	date DATE NOT NULL,
	time TIME NOT NULL,
	payment_method VARCHAR(15) NOT NULL,
	cogs DECIMAL(10, 2) NOT NULL,
	gross_margin_percentage FLOAT(11, 9) NOT NULL,
	gross_income DECIMAL(12, 4) NOT NULL,
	rating FLOAT(2, 1) NOT NULL
);

-----------------------------------------------------------------------------------------------------------------------------------------------
--- --- 1. Selecting day_of_time

SELECT time,
	(CASE
		WHEN 'time' > "00:00:00" AND time < "12:00:00" THEN "Morning"
        WHEN 'time' > "12:00:01" AND time < "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
	) AS "time_of_day"
FROM Sales;


ALTER TABLE Sales
ADD COLUMN time_of_day VARCHAR(10);

UPDATE Sales
SET time_of_day =
	(CASE
		WHEN 'time' > "00:00:00" AND time < "12:00:00" THEN "Morning"
        WHEN 'time' > "12:00:01" AND time < "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
);


-----------------------------------------------------------------------------------------------------------------------------------------------
---- 2. Add new column "day_name"  ---------------------------------------------------------------------------------------------------------

SELECT date, dayname(date) AS "day_name"
FROM Sales;

ALTER TABLE Sales
ADD COLUMN day_name VARCHAR(10);

UPDATE Sales
SET day_name = dayname(date);

-----------------------------------------------------------------------------------------------------------------------------------------------
---- 3. Add new column "month_name" -----------------------------------------------------------------------------------------------------------
UPDATE Sales
SET month_name = monthname(date);

ALTER TABLE Sales ADD COLUMN month_name VARCHAR(15);
 

----------------------------------- General Questions ------------------------------------------------------------------
---- 1. How many unique cities does the data have?

SELECT DISTINCT city FROM Sales;

---- 2. In which city is each branch?

SELECT DISTINCT city, branch FROM Sales;

----------------------------------- Products ------------------------------------------------------------------

---- 1. How many unique product lines does the data have?

SELECT COUNT(DISTINCT product_line) AS "No.of product_line" FROM Sales;

---- 2. What is the most common payment method?

SELECT payment_method, COUNT(payment_method) AS "count" FROM Sales
GROUP BY payment_method
ORDER BY count ASC;

---- 3. What is the most selling product line?

SELECT product_line, COUNT(product_line) AS "count" FROM Sales
GROUP BY product_line
ORDER BY count DESC LIMIT 1;

---- 4. What is the total revenue by month?

SELECT month_name, SUM(total) AS "total" FROM sales
GROUP BY month_name
ORDER by "total" DESC;

---- 5. What month had the largest COGS?

SELECT month_name, SUM(cogs) AS "COGS"
FROM Sales
GROUP BY month_name
ORDER BY COGS DESC;



---- 6. What product line had the largest revenue?

SELECT product_line, SUM(total) AS "largest"
FROM Sales
GROUP BY product_line
ORDER BY largest DESC LIMIT 1;

---- 7. What is the city with the largest revenue?

SELECT branch, city, SUM(total) AS "largest"
FROM Sales
GROUP BY city
ORDER BY largest DESC LIMIT 1;

---- 8. What product line had the largest VAT?

SELECT product_line, SUM(VAT) AS "largest"
FROM Sales
GROUP BY product_line
ORDER by largest DESC;

---- 9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales

SELECT product_line, (
	CASE
		WHEN total > (SELECT AVG(total) FROM Sales) THEN "Good"
        ELSE "Bad"
	END
) AS "column"
FROM Sales;

---- 10. Which branch sold more products than average product sold?

SELECT branch, SUM(quantity) as "sold"
FROM Sales
GROUP BY branch
HAVING sold > (SELECT AVG(quantity) FROM Sales);

---- 11. What is the most common product line by gender?

SELECT gender, product_line, COUNT(gender) as "count"
FROM Sales
GROUP BY gender, product_line
ORDER BY count DESC;

---- 12. What is the average rating of each product line?

SELECT product_line, ROUND(AVG(rating),2) as "avg"
FROM Sales
GROUP BY product_line
ORDER BY avg DESC;


----------------------------------- Sales ------------------------------------------------------------------

---- 1. Number of sales made in each time of the day per weekday

SELECT time_of_day, COUNT(*) AS count
FROM Sales
GROUP BY time_of_day
ORDER BY count DESC;

--- 2. Which of the customer types brings the most revenue?

SELECT customer_type, SUM(total) AS total
FROM Sales
GROUP BY customer_type
ORDER BY total DESC;

---- 3. Which city has the largest tax percent/ VAT (Value Added Tax)?

SELECT city, AVG(VAT) AS "largest"
FROM Sales
GROUP BY city
ORDER BY largest DESC;

---- 4. Which customer type pays the most in VAT?

SELECT customer_type, AVG(VAT) AS "most"
FROM Sales
GROUP BY customer_type
ORDER BY most DESC;

----------------------------------- Customer ------------------------------------------------------------------

---- 1. How many unique customer types does the data have?

SELECT COUNT(DISTINCT customer_type) FROM Sales;

---- 2. How many unique payment methods does the data have?

SELECT COUNT(DISTINCT payment_method) FROM Sales;

---- 3. What is the most common customer type?

SELECT customer_type, COUNT(customer_type) AS count
FROM Sales
GROUP BY customer_type
ORDER BY count DESC;

---- 4. Which customer type buys the most?

SELECT customer_type, COUNT(*) AS count
FROM Sales
GROUP BY customer_type
ORDER BY count;

---- 5. What is the gender of most of the customers?

SELECT gender, COUNT(customer_type) AS count
FROM Sales
GROUP BY gender
ORDER BY count;

---- 6. What is the gender distribution per branch?

SELECT gender, COUNT(gender)
FROM sales
WHERE branch LIKE "c"
GROUP BY gender;

---- 7. Which time of the day do customers give most ratings?

SELECT time_of_day, COUNT(rating) AS "rating"
FROM Sales
GROUP BY time_of_day
ORDER BY rating DESC;

---- 8. Which time of the day do customers give most ratings per branch?

SELECT time_of_day, COUNT(rating) AS "rating"
FROM Sales
WHERE branch = "c"
GROUP BY time_of_day
ORDER BY rating DESC;

---- 9. Which day of the week has the best avg ratings?

SELECT day_name, AVG(rating) AS "avg"
FROM Sales
GROUP BY day_name
ORDER BY avg DESC;

---- 10. Which day of the week has the best average ratings per branch?

SELECT day_name, AVG(rating) AS "avg"
FROM Sales
WHERE branch = "c"
GROUP BY day_name
ORDER BY avg DESC;





