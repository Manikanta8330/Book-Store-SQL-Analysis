# Book Store SQL Analysis

## Project Overview

This project analyzes a bookstore database using SQL to understand sales performance, customer purchasing behavior, product and genre performance, and inventory position.

The project uses three main tables:

- Books
- Customers
- Orders

## Objectives

The analysis focuses on:

- Exploring the bookstore data
- Understanding sales performance
- Analyzing customer purchasing behavior
- Identifying high-performing books, authors, and genres
- Analyzing inventory levels
- Identifying sales and inventory opportunities

## Tools Used

- MySQL
- SQL
- GitHub

## Database Structure

### Books

Contains information about books, including:

- Book ID
- Title
- Author
- Genre
- Published Year
- Price
- Stock

### Customers

Contains customer information, including:

- Customer ID
- Name
- Email
- Phone
- City
- Country

### Orders

Contains order information, including:

- Order ID
- Customer ID
- Book ID
- Order Date
- Quantity
- Total Amount

## SQL Concepts Used

- SELECT
- WHERE
- DISTINCT
- Aggregate Functions
- GROUP BY
- HAVING
- ORDER BY
- INNER JOIN
- LEFT JOIN
- COALESCE
- Date Functions
- Data Validation
- Primary Key Checks
- Foreign Key Consistency Checks

## Analysis Performed

### Sales Performance

- Overall order volume
- Total books sold
- Total revenue
- Revenue by book
- Revenue by author
- Revenue by genre
- Monthly sales trends
- Yearly sales trends
- Highest-selling books

### Customer Purchasing Behaviour

- Orders per customer
- Customer spending
- Average customer spending
- Repeat customers
- Customers by country
- Revenue by country
- Customers purchasing across multiple genres
- Customer purchasing trends over time

### Product & Genre Performance

- Books with highest sales volume
- Books generating highest revenue
- Genre-wise sales
- Genre-wise revenue
- Author-wise sales
- Highest-priced books
- Low-selling books
- Books that have never been ordered
- Price and sales analysis

### Inventory Analysis

- Current stock levels
- Low-stock books
- Stock by genre
- Inventory value by genre
- Inventory value by author
- High-value inventory
- High-stock books with low sales
- Low-stock books with high sales
- Books in stock that have never been ordered

### Sales & Inventory Opportunities

- High-selling books with low stock
- High-stock books with low sales
- Popular genres with limited inventory
- Books showing strong demand
- Products that may require promotional attention
- Products that may require replenishment

## Project Files

- `BookVerse_Database.sql` — Database and table creation script
- `Analysis_Queries.sql` — SQL queries used for data exploration and analysis

## Author

**Manikanta**
