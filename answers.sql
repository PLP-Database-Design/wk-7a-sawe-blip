-- 1NF: Normalize ProductDetail table

IF OBJECT_ID('ProductDetail') IS NOT NULL DROP TABLE ProductDetail;

CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES 
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Split Products into individual rows
SELECT 
    OrderID,
    CustomerName,
    LTRIM(RTRIM(value)) AS Product
INTO ProductDetail_1NF
FROM 
    ProductDetail
CROSS APPLY 
    STRING_SPLIT(Products, ',');

SELECT * FROM ProductDetail_1NF;

-- 2NF: Normalize OrderDetails table

IF OBJECT_ID('OrderDetails') IS NOT NULL DROP TABLE OrderDetails;

CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES 
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Create Orders table
SELECT DISTINCT 
    OrderID,
    CustomerName
INTO Orders
FROM OrderDetails;

-- Create OrderItems table
SELECT 
    OrderID,
    Product,
    Quantity
INTO OrderItems
FROM OrderDetails;

SELECT * FROM Orders;
SELECT * FROM OrderItems;
