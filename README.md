# Walmart-Sales-Data-Analysis

"Walmart is a large retail corporation that operates a chain of discount department stores, hypermarkets, and grocery stores. It's known for offering a wide variety of products at affordable prices, including groceries, clothing, electronics, household goods, and more. Walmart is one of the world's largest retailers and serves millions of customers globally both in physical stores and online."

Walmart Sales Data Analysis is a project aimed at extracting valuable insights from sales data collected by Walmart. The project involves analyzing various aspects of sales data, including product lines, branch performance, customer behavior, and sales trends over time, customer trends and many more.

---
### Columns Include : 
- Invoice ID --> Unique identifier for each transaction.
- Branch --> Indicates the branch where the transaction took place.
- City --> City where the branch is located.
- Customer Type --> Type of customer, such as Member or Normal.
- Gender --> Gender of the customer.
- Product Line --> Category or type of product sold.
- Unit Price --> Price per unit of the product.
- Quantity --> Number of units of the product sold.
- Tax 5% --> Tax amount calculated at 5% of the total.
- Total --> Total amount of the transaction including tax.
- Date --> Date of the transaction.
- Time --> Time of the transaction.
- Payment --> Payment method used for the transaction.
- COGS (Cost of Goods Sold) --> The direct costs attributable to the production of goods sold in the transaction.
- Gross Margin Percentage --> Percentage of revenue that exceeds the COGS.
- Gross Income --> Revenue generated after deducting the COGS.
- Rating --> Rating provided by the customer for the transaction.
---
### Through this analysis, I seek to understand of the following:
1. Created a Database
2. Created a Table "salesData"
3. Total 17 Columns (Invoice ID, Branch, City, Customer Type, Gender, Product Line, Unit Price, Quantity, Tax 5%, Total, Date, Time, Payment, COGS, Gross Margin Percentage, Gross Income, Rating)
4. Convert column "date_" from varchar to DATE format
5. Convert VARCHAR to DATE datatype
6. Calculated Basic Statistics
    - Mean, Median, Mode, Minimum, Maximum, and Standard Deviation for "Unit Price" column
7. Customer Analysis:
    - The number of unique customers and the number of each type of customer
8. Geographical Analysis:
    - What are the unique cities where branches are located?
    - How many branches are there in each city?
    - What are the sales figures for each city?
9. Product Analysis:
    - What are the different product lines?
    - How many units of each product line were sold?
    - What is the total revenue generated by each product line?
10. Sales Performance:
    - What is the total revenue?
    - What is the total tax collected?
    - What is the gross income?
    - What is the cost of goods sold (COGS)?
    - What is the gross margin percentage?
11. Time Analysis:
    - What are the sales figures for each date?
    - What are the sales figures for each time slot?
    - What is the trend of sales over time (Year, Month, Weekdays, Date)?
12. Payment Analysis:
    - What are the different payment methods?
    - How many transactions were made using each payment method?
    - What is the revenue generated through each payment method?
13. Customer Satisfaction:
    - What are the different ratings provided by customers?
    - What is the average rating?
    - How many customers gave a rating above a certain threshold (i.e. above 5.0)?
