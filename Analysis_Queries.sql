SELECT * FROM Books
LIMIT 10;

SELECT * FROM Customers
LIMIT 10;

SELECT * FROM Orders
LIMIT 10;

-- Check for duplicate Primary Keys

-- BOOKS
SELECT Book_ID, COUNT(*) AS count
FROM Books
GROUP BY Book_ID
HAVING COUNT(*) > 1;

-- CUSTOMERS 
SELECT Customer_ID, COUNT(*) AS count
FROM Customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- ORDERS
SELECT Order_ID, COUNT(*) AS count
FROM Orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;

-- Check missing values

-- BOOKS
SELECT
    SUM(Book_ID IS NULL) AS Book_ID_Null,
    SUM(Title IS NULL) AS Title_Null,
    SUM(Author IS NULL) AS Author_Null,
    SUM(Genre IS NULL) AS Genre_Null,
    SUM(Published_Year IS NULL) AS Year_Null,
    SUM(Price IS NULL) AS Price_Null,
    SUM(Stock IS NULL) AS Stock_Null
FROM Books;

-- CUSTOMERS 
SELECT
    SUM(Customer_ID IS NULL) AS Customer_ID_Null,
    SUM(Name IS NULL) AS Name_Null,
    SUM(Email IS NULL) AS Email_Null,
    SUM(Phone IS NULL) AS Phone_Null,
    SUM(City IS NULL) AS City_Null,
    SUM(Country IS NULL) AS Country_Null
FROM Customers;

-- ORDERS
SELECT
    SUM(Order_ID IS NULL) AS Order_ID_Null,
    SUM(Customer_ID IS NULL) AS Customer_ID_Null,
    SUM(Book_ID IS NULL) AS Book_ID_Null,
    SUM(Order_Date IS NULL) AS Order_Date_Null,
    SUM(Quantity IS NULL) AS Quantity_Null,
    SUM(Total_Amount IS NULL) AS Total_Amount_Null
FROM Orders;

-- Check Foreign Key Consistency

-- BOOKS
SELECT o.Book_ID
FROM Orders o
LEFT JOIN Books b
    ON o.Book_ID = b.Book_ID
WHERE b.Book_ID IS NULL;

-- CUSTOMERS 
SELECT o.Customer_ID
FROM Orders o
LEFT JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

-- Sprint 3: Basic Analysis / Data Exploration.

-- 1. What is the total number of books?
SELECT COUNT(*) FROM BOOKS;

-- 2. What is the total number of customers?
SELECT COUNT(*) FROM CUSTOMERS;

-- 3. What is the total number of orders?  
SELECT COUNT(*) FROM ORDERS;

-- 4. What are the different genres available?
SELECT DISTINCT Genre
FROM Books;

-- 5. What are the different countries represented in the customer data?
SELECT DISTINCT Country
FROM CUSTOMERS;

-- 6. What is the total quantity of books sold?
SELECT SUM(Quantity) AS total_books_sold
FROM ORDERS;

-- 7. What is the total revenue generated?
SELECT SUM(Total_Amount) AS total_revenue
FROM ORDERS;

-- 8. What is the average order value? 
SELECT AVG(Total_Amount) AS average_order_value
FROM ORDERS;

-- Sprint 4: Objective-Based Business 
-- Analysis

-- Sprint 4.1 — Sales Performance

-- 1. Overall order volume
SELECT 
	b.Title, 
	SUM(o.Total_Amount) AS total_revenue
FROM Books AS b
JOIN Orders AS O
     ON b.Book_ID = o.Book_ID
GROUP BY b.Title 
ORDER BY total_revenue DESC;

-- Q2. How many books have been sold in total?
-- → Total quantity sold
SELECT SUM(Quantity) AS Total_books_sold
FROM ORDERS;

-- Q3. What is the total revenue generated?
-- ● Total revenue. 
SELECT SUM(Total_Amount) as Total_revenue 
FROM ORDERS;

-- Q4. Which books generate the highest revenue?
-- Sales by Book
SELECT b.Title , SUM(o.Total_Amount) AS Total_revenue
FROM Books b
JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Title 
ORDER BY Total_revenue DESC;

-- Q5. Which authors generate the highest total revenue?
-- Sales by author.
SELECT b.Author , SUM(o.Total_Amount) AS Total_Revenue
FROM Books b
JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Total_Revenue DESC;

-- Q6. Which genres generate the highest total revenue?
--  Sales by genre. 
SELECT b.Genre , SUM(o.Total_Amount) AS Highest_Total_Revenue
FROM Books b
JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Highest_Total_Revenue DESC;

-- Q7. How does total revenue change month by month?
-- Monthly Sales Trend
SELECT 
    MONTHNAME(Order_Date) AS Sales_Month,
    SUM(Total_Amount) AS Total_Revenue
FROM Orders
GROUP BY MONTH(Order_Date), MONTHNAME(Order_Date)
ORDER BY MONTH(Order_Date);

-- Q8. How does total revenue change year by year?
-- Yearly Sales Trend
SELECT 
    YEAR(Order_Date) AS Sales_Year,
    SUM(Total_Amount) AS Total_Revenue
FROM Orders
GROUP BY YEAR(Order_Date)
ORDER BY Sales_Year;

-- Q9 — Which books generate the highest revenue per book?
--  High-value books. 
SELECT 
    b.Title,
    SUM(o.Total_Amount) AS Total_Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY Total_Revenue DESC;

-- Q10 — Which books have sold the highest number of copies?
-- High-volume books.
SELECT 
    b.Title,
    SUM(o.Quantity) AS Total_Copies_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY Total_Copies_Sold DESC;

-- Sprint 4.2 — Customer Purchasing Behaviour

-- Q1. How many orders has each customer placed?
--  Number of orders per customer
SELECT 
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Orders DESC;

-- Q2. Which customers have spent the most money?
-- Total purchase amount. 
SELECT 
    c.Customer_ID,
    c.Name,
    SUM(o.Total_Amount) AS Total_Spent
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Total_Spent DESC;

-- Q3. What is the average amount spent by each customer?
--  Average customer spending.  
SELECT 
    c.Customer_ID,
    c.Name,
    AVG(o.Total_Amount) AS Average_Spending
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Average_Spending DESC;

-- Q4. Who are the repeat customers?
-- Repeat customers. 
SELECT 
    c.Customer_ID,
    c.Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) > 1
ORDER BY Total_Orders DESC;

-- Q5. Which countries have the highest number of customers?
--  Customer activity by country.
SELECT 
    Country,
    COUNT(Customer_ID) AS Total_Customers
FROM Customers
GROUP BY Country
ORDER BY Total_Customers DESC;

-- Q6. Which countries generate the highest total revenue?
SELECT 
    c.Country,
    SUM(o.Total_Amount) AS Total_Revenue
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Country
ORDER BY Total_Revenue DESC;

-- Q7. Which customers have purchased books from multiple genres?
 -- Customers purchasing across multiple genres.
 SELECT 
    c.Customer_ID,
    c.Name,
    COUNT(DISTINCT b.Genre) AS Number_of_Genres
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Books b
    ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(DISTINCT b.Genre) > 1
ORDER BY Number_of_Genres DESC;

-- Q8. How does customer purchasing behaviour change over time?
 -- Customer purchasing behaviour over time. 
 SELECT 
    YEAR(o.Order_Date) AS Sales_Year,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Quantity) AS Total_Books_Sold,
    SUM(o.Total_Amount) AS Total_Revenue
FROM Orders o
GROUP BY YEAR(o.Order_Date)
ORDER BY Sales_Year;



-- Sprint 4.3 — Product & Genre Performance

-- Q1. Which books have sold the highest number of copies?
-- Books with the highest quantity sold. 
SELECT 
    b.Title,
    SUM(o.Quantity) AS Total_Copies_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY Total_Copies_Sold DESC;

-- Q2. Which books generate the highest revenue?
-- Books generating the highest revenue.
SELECT 
    b.Title,
    SUM(o.Total_Amount) AS Total_Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY Total_Revenue DESC; 

-- Q3. Which genres have the highest sales volume?
--  Genre-wise sales.
SELECT 
    b.Genre,
    SUM(o.Quantity) AS Total_Sales
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Total_Sales DESC;

-- Q4. Which genres generate the highest revenue?
-- Genre-wise revenue.
SELECT 
    b.Genre,
    SUM(o.Total_Amount) AS Total_Revenue
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
ORDER BY Total_Revenue DESC;

-- Q5. Which authors have the highest sales volume?
--  Author-wise performance.
SELECT 
    b.Author,
    SUM(o.Quantity) AS Total_Copies_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Author
ORDER BY Total_Copies_Sold DESC;

-- Q6. Which books have the highest prices?
-- Author-wise performance. 
SELECT 
    Title,
    Price
FROM Books
ORDER BY Price DESC;

-- Q7. Which books have the lowest sales?
-- Books with low sales.
SELECT 
    b.Title,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Total_Copies_Sold ASC;

-- Q8. Which books have never been ordered?
-- Books that have never been ordered.
SELECT 
    b.Book_ID,
    b.Title
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL;

-- Q9. Is there a relationship between book price and sales?
-- Relationship between product price and sales.
SELECT 
    b.Title,
    b.Price,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Price
ORDER BY b.Price DESC;


-- Sprint 4.4 — Understand Inventory Position


-- Q1. What is the current stock level of each book?
--  Current stock levels
SELECT 
    Book_ID,
    Title,
    Stock
FROM Books
ORDER BY Stock DESC;

-- Q2. Which books have low stock levels?
--  Low-stock books.
SELECT 
    Book_ID,
    Title,
    Stock
FROM Books
WHERE Stock <= 10
ORDER BY Stock ASC;

-- Q3. How much stock is available in each genre?
--  Stock by genre. 
SELECT 
    Genre,
    SUM(Stock) AS Total_Stock
FROM Books
GROUP BY Genre
ORDER BY Total_Stock DESC;

-- Q4. What is the total inventory value for each genre?
-- Inventory value by genre.
SELECT 
    Genre,
    SUM(Price * Stock) AS Inventory_Value
FROM Books
GROUP BY Genre
ORDER BY Inventory_Value DESC;

-- Q5. What is the total inventory value for each author?
-- Inventory value by author.
SELECT 
    Author,
    SUM(Price * Stock) AS Inventory_Value
FROM Books
GROUP BY Author
ORDER BY Inventory_Value DESC;

-- Q6. Which books have the highest inventory value?
-- High-value inventory. 
SELECT 
    Book_ID,
    Title,
    Price,
    Stock,
    Price * Stock AS Inventory_Value
FROM Books
ORDER BY Inventory_Value DESC;

-- Q7. Which books have high stock but low sales?
-- Books with high stock but low sales. 
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
HAVING b.Stock > 50
   AND Total_Copies_Sold < 10
ORDER BY b.Stock DESC;

-- Q8. Which books have low stock but high sales?
-- Books with low stock and high sales.
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
HAVING b.Stock <= 10
   AND Total_Copies_Sold > 20
ORDER BY Total_Copies_Sold DESC;

-- Q9. Which books are currently in stock but have never been ordered?
--  Books that have never been ordered.
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL
  AND b.Stock > 0
ORDER BY b.Stock DESC;

-- Sprint 4.5 — Sales & Inventory Opportunities


-- Q1. Which high-selling books have low stock?
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
HAVING b.Stock <= 10
   AND Total_Copies_Sold > 10
ORDER BY Total_Copies_Sold DESC;

-- Q2. Which high-stock books have low sales?
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
HAVING b.Stock > 50
   AND Total_Copies_Sold < 10
ORDER BY b.Stock DESC;

-- Q3. Which popular genres have limited inventory?
SELECT 
    b.Genre,
    SUM(o.Quantity) AS Total_Copies_Sold,
    SUM(b.Stock) AS Total_Stock
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Genre
HAVING Total_Copies_Sold > 20
   AND Total_Stock < 50
ORDER BY Total_Copies_Sold DESC;

-- Q5. Which books show strong demand?
SELECT 
    b.Book_ID,
    b.Title,
    SUM(o.Quantity) AS Total_Copies_Sold
FROM Books b
JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title
ORDER BY Total_Copies_Sold DESC;

-- Q6. Which books have never been ordered?
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
WHERE o.Book_ID IS NULL
ORDER BY Stock DESC;

-- Q7. Which customers purchase books across multiple genres?
SELECT 
    c.Customer_ID,
    c.Name,
    COUNT(DISTINCT b.Genre) AS Number_of_Genres
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
JOIN Books b
    ON o.Book_ID = b.Book_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(DISTINCT b.Genre) > 1
ORDER BY Number_of_Genres DESC;

-- Q8. Which products may require promotional attention?
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
HAVING b.Stock > 50
   AND Total_Copies_Sold < 10
ORDER BY b.Stock DESC;

-- Q9. Which products may require replenishment?
SELECT 
    b.Book_ID,
    b.Title,
    b.Stock,
    COALESCE(SUM(o.Quantity), 0) AS Total_Copies_Sold
FROM Books b
LEFT JOIN Orders o
    ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
HAVING b.Stock <= 10
   AND Total_Copies_Sold > 20
ORDER BY Total_Copies_Sold DESC;


SELECT * FROM BOOKS;
SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
