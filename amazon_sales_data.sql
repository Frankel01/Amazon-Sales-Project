SELECT * From amazon_sales_data

--- What is the total sales per month?
SELECT SUM(Total_Sales) as Total_Revenue
from amazon_sales_data

----Which product generated the highest total sales?
select amazon_sales_data.Product, 
Sum(Total_Sales) as Total_Sales from amazon_sales_data
group by amazon_sales_data.Product
Order by Total_Sales desc;

----What is the average order value per product or category?
select Count(Order_ID) AS AVG_Order, Category
from amazon_sales_data
Group by Category
Order By AVG_Order desc;

----What is the total sales per category?
select Category, SUM(Total_Sales) as Total_Sales
From amazon_sales_data
Group by Category
Order by Total_Sales desc;

----Which month had the highest number of sales transactions?
select Months, Count(Order_ID) as Count_of_Orders,
SUM(Total_Sales) as Total_Sales
From amazon_sales_data
Group by Months
Order by Total_Sales desc;

-----What are the top 5 best-selling products by quantity?

SELECT Top 5
amazon_sales_data.Product, COUNT(Quantity) AS Quantites
From amazon_sales_data
Group by amazon_sales_data.Product, Quantity;

----Which products have the highest return/cancellation rate?
SELECT amazon_sales_data.Product, amazon_sales_data.Status, 
Count(amazon_sales_data.Status) as Count_of_Status
From amazon_sales_data
group by amazon_sales_data.Product, 
amazon_sales_data.Status;

----Who are the top 10 customers based on Purchase Frequency and total sales?
SELECT TOP 10
Customer_Name, Count(Order_ID) AS Purchase_Frequency,
SUM(Total_Sales) as Total_Sales
From amazon_sales_data
Group by Customer_Name
Order BY Total_Sales desc;

---- How many unique customers made purchases?
SELECT
Count(Distinct [Order_ID]) as Unique_Customers
from amazon_sales_data;

----What is the average number of orders per customer?
SELECT 
	cast(COUNT(*) as float) / count(distinct[Customer_Name]) AS AVG_Customer
From amazon_sales_data
where amazon_sales_data.Status <> 'Cancelled';

----What is the count of customers by location that has the highest sales volume?
select Customer_Location, Count(Customer_Name) as Count_of_Customers,
SUM(Total_Sales) AS Total_Sales
From amazon_sales_data
Group BY Customer_Location
Order BY Total_Sales desc;

----What is the customer churn rate based on canceled orders?
SELECT COUNT(Customer_Name) as Churn_Customers
From amazon_sales_data
WHERE amazon_sales_data.Status != 'Cancelled';

----What is the distribution of order status (Pending, Cancelled, etc.) by customer?
SELECT 
    Customer_Name,
    amazon_sales_data.Status,
    COUNT(*) AS order_count
FROM amazon_sales_data
GROUP BY Customer_Name, amazon_sales_data.Status
ORDER BY Customer_Name, amazon_sales_data.Status;

-----Which categories have the most orders?
SELECT 
Category, Count(Order_ID) AS Count_of_Orders
From amazon_sales_data
Group by Category
Order By Count_of_Orders DESC;

----Which products are most frequently cancelled?
SELECT
amazon_sales_data.Product, Count(Order_ID) as Cancellation_Count
From amazon_sales_data
WHERE Status = 'Cancelled'
Group BY amazon_sales_data.Product
Order By Cancellation_Count DESC;

----Which product had the most revenue loss due to cancellations?
SELECT
amazon_sales_data.Product, Count(Order_ID) as Revenue_Count, 
SUM(Total_Sales) as Total_revenue
From amazon_sales_data
WHERE Status = 'Cancelled'
Group BY amazon_sales_data.Product
Order By Total_revenue DESC;

-----What is the most preferred payment method overall?
SELECT Payment_Method, 
Count(Order_ID) as Payment_Method_Count
From amazon_sales_data
Group By Payment_Method
Order By Payment_Method_Count Desc;

----What is the total sales per payment method?
SELECT Payment_Method, 
SUM(Total_Sales) as Payment_Method_Revenue
From amazon_sales_data
Group By Payment_Method
Order By Payment_Method_Revenue Desc;

----Are there any days or months with an abnormal spike in cancellations or sales?
SELECT
Months, Count(Order_ID) AS Customer_Count
From amazon_sales_data
WHERE amazon_sales_data.Status = 'Cancelled'
Group By Months;

----Which products are most often paid for using a specific payment method?
SELECT amazon_sales_data.Product, Payment_Method, 
Count(*) as Count_of_Payment_Method
From amazon_sales_data
Group By amazon_sales_data.Product, Payment_Method
Order By Count_of_Payment_Method desc;
