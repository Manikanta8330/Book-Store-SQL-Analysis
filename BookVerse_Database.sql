CREATE DATABASE BookVerse_DB;

USE BookVerse_DB;

CREATE TABLE Books
(
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(250) NOT NULL,
    Author VARCHAR(150) NOT NULL,
    Genre VARCHAR(80),
    Published_Year YEAR,
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Customers
(
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(120),
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(20),
    City VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Ordersbooks
(
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2),

    CONSTRAINT FK_Order_Customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID),

    CONSTRAINT FK_Order_Book
        FOREIGN KEY (Book_ID)
        REFERENCES Books(Book_ID)
);