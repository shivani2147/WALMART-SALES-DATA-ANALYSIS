# Create a Database "WalmartSalesData"
CREATE DATABASE IF NOT EXISTS WalmartSalesData;

# Use this Database
USE WalmartSalesData;

# Create a Table "salesData" if not exist
CREATE TABLE IF NOT EXISTS salesData (invoice_id VARCHAR(30) NOT NULL, branch VARCHAR(10) NOT NULL, city VARCHAR(30) NOT NULL, 
									  customer_type VARCHAR(30) NOT NULL, gender VARCHAR(10) NOT NULL, 
                                      product_line VARCHAR(100) NOT NULL, unit_price DECIMAL(10, 2) NOT NULL, 
                                      quantity INT NOT NULL, tax DECIMAL(10, 4) NOT NULL, total DECIMAL(15, 4) NOT NULL, 
                                      date_ VARCHAR(30) NOT NULL, time_ TIME NOT NULL, payment VARCHAR(30) NOT NULL, 
                                      cogs DECIMAL(10, 2) NOT NULL, gross_margin_pct DECIMAL(12, 9) NOT NULL, 
                                      gross_income DECIMAL(15, 4) NOT NULL, rating DECIMAL(5, 1) NOT NULL, 
                                      PRIMARY KEY (invoice_id)); 
           
# Check the details of the table
SELECT * FROM salesData;

# DESCRIBE dataset
DESC salesData;

# Convert column "date_" from varchar to date format 
UPDATE salesData SET date_ = STR_TO_DATE(date_, '%d-%m-%Y');

# Convert varchar to date datatype
ALTER TABLE salesData MODIFY date_ DATE;

# CALCULATING BASIC STATISTICS 
# Mean, Median, Mode, Minimum, Maximum, and Standard Deviation for "Unit Price" column
SELECT unit_price AS Unit_Price, 
	ROUND(AVG(unit_price), 2) AS Mean, 
    (SELECT ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY unit_price) OVER(), 2) AS Median FROM salesData LIMIT 1) AS Median, 
    (SELECT unit_price FROM salesData GROUP BY unit_price ORDER BY COUNT(*) DESC LIMIT 1) AS Mode, 
    MIN(unit_price) AS Minimum, 
    MAX(unit_price) AS Maximum, 
    ROUND(STDDEV(unit_price), 2) AS Standard_Deviation 
FROM salesData;

# Count the number of unique values in Categorical Columns
SELECT 
	COUNT(DISTINCT branch) AS Branches, 
    COUNT(DISTINCT city) AS Cities, 
    COUNT(DISTINCT customer_Type) AS Customer_Types,
    COUNT(DISTINCT gender) AS Genders,
    COUNT(DISTINCT product_line) AS Product_Lines,
    COUNT(DISTINCT payment) AS Payments
FROM salesData;

----------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------- CUSTOMER ANALYSIS --------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

# The number of unique customers and the number of each type of customer
SELECT DISTINCT customer_type, COUNT(*) AS Count_of_Customers FROM salesData GROUP BY customer_type ORDER BY Count_of_Customers DESC;

----------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------- GEOGRAPHICAL ANALYSIS -----------------------------------------------
----------------------------------------------------------------------------------------------------------------------

# What are the unique cities where branches are located?
SELECT DISTINCT city, branch FROM salesData;	

# How many branches are there in each city?
SELECT city, COUNT(DISTINCT branch) AS Num_Branches FROM salesData GROUP BY city ORDER BY Num_Branches  DESC;

# What are the sales figures for each city ?
SELECT city, ROUND(SUM(total), 2) AS Total_Sales FROM salesData GROUP BY city ORDER BY Total_Sales DESC;

----------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------- PRODUCT ANALYSIS ---------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

# What are the different product lines?
SELECT DISTINCT product_line FROM salesData;

# How many units of each product line were sold?
SELECT DISTINCT product_line, SUM(quantity) as Total_Units_Sold FROM salesData GROUP BY product_line ORDER BY Total_Units_Sold DESC;

----------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------- SALES PERFORMANCE --------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

# What is the total revenue?
SELECT SUM(total) AS Total_Revenue FROM salesData;

# What is the total tax collected?
SELECT SUM(tax) AS Total_Tax_Collected FROM salesData;

# What is the gross income?
SELECT SUM(gross_income) AS Total_Gross_Income FROM salesData;

# What is the Cost of Goods Sold (COGS)?
# To calculate the COGS, use the formula:
-- COGS = Total - Tax - Gross Income
SELECT SUM(total - tax - gross_income) AS Total_COGS FROM salesData;

# What is the Gross Margin Percentage?
# Formula : 
-- Gross Margin Percentage = (Gross Income / Total Revenue) × 100
SELECT (SUM(gross_income) * 100) / SUM(total) AS Gross_Margin_Percentage FROM salesData;

----------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------- TIME ANALYSIS ------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

# What are the sales figures for each date?
SELECT date_, ROUND(SUM(total), 2) AS Total_Sales FROM salesData GROUP BY date_ ORDER BY date_;

# What are the sales figures for each time slot?
SELECT 
	CASE
		WHEN time_ BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN time_ BETWEEN "12:01:00" AND "17:00:00" THEN "Afternoon"
        WHEN time_ BETWEEN "17:01:00" AND "24:00:00" THEN "Evening"
	END AS Time_Slot, 
    SUM(TOTAL) AS Total_Sales
FROM salesData GROUP BY Time_Slot ORDER BY Time_Slot DESC;

# What is the trend of sales over time (Year, Month, Weekdays, Date)?
SELECT YEAR(date_) AS Year, MONTHNAME(date_) AS Month, DAYNAME(date_) AS Weekdays, date_ AS Date, ROUND(SUM(total), 2) AS Total_Sales FROM salesData 
	   GROUP BY Month, Weekdays ORDER BY Date;

----------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------- PAYMENT ANALYSIS ---------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

# What are the different payment methods?
select DISTINCT payment FROM salesData;

# How many transactions were made using each payment method?
select DISTINCT payment, COUNT(*) AS Num_Transactions FROM salesData GROUP BY payment ORDER BY Num_Transactions DESC;

# What is the revenue generated through each payment method?
select DISTINCT payment, ROUND(SUM(total), 2) AS Total_Revenue FROM salesData GROUP BY payment ORDER BY Total_Revenue DESC;

----------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------- CUSTOMER SATISFACTION -------------------------------------------------
----------------------------------------------------------------------------------------------------------------------

# What are the different ratings provided by customers?
select DISTINCT rating FROM salesData;

# What is the average rating?
select AVG(rating) AS Average_Rating FROM salesData;

# How many customers gave a rating above a certain threshold (i.e. above 5.0)?
SELECT COUNT(rating) AS Num_Customers FROM salesData WHERE rating > 5.0;