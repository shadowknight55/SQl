-- 1. Create the database
CREATE DATABASE IF NOT EXISTS ecommerce_store;
USE ecommerce_store;

-- 2. Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 3. Create the customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10)
);

-- 4. Create the products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Create the orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- 6. Create the order_details table
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_per_product DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- 7. Insert sample data into customers table
INSERT INTO customers (first_name, last_name, email, phone_number, city, state, zip_code)
VALUES 
('John', 'Doe', 'johndoe@example.com', '123-456-7890', 'Springfield', 'IL', '62701'),
('Jane', 'Smith', 'janesmith@example.com', '987-654-3210', 'Homer', 'AK', '99603'),
('Alice', 'Johnson', 'alicej@example.com', '555-123-4567', 'Portland', 'OR', '97205');

-- 8. Insert sample data into products table
INSERT INTO products (name, description, price, stock_quantity)
VALUES 
('Laptop', 'A high-end laptop', 1200.00, 50),
('Smartphone', 'A latest model smartphone', 800.00, 100),
('Headphones', 'Noise-canceling headphones', 150.00, 200),
('Tablet', 'A lightweight tablet', 500.00, 75),
('Monitor', '4K Ultra HD monitor', 300.00, 30);

-- 9. Insert sample data into orders table
INSERT INTO orders (customer_id, total_amount, order_status)
VALUES 
(1, 1200.00, 'Shipped'),
(2, 1000.00, 'Delivered'),
(1, 800.00, 'Pending'),
(3, 450.00, 'Shipped'),
(2, 300.00, 'Pending');

-- 10. Insert sample data into order_details table
INSERT INTO order_details (order_id, product_id, quantity, price_per_product)
VALUES 
(1, 1, 1, 1200.00),  -- John Doe ordered 1 Laptop
(2, 2, 1, 800.00),   -- Jane Smith ordered 1 Smartphone
(3, 2, 1, 800.00),   -- John Doe ordered 1 Smartphone
(4, 4, 1, 500.00),   -- Alice Johnson ordered 1 Tablet
(4, 3, 2, 150.00),   -- Alice Johnson ordered 2 Headphones
(5, 5, 1, 300.00),   -- Jane Smith ordered 1 Monitor
(5, 3, 1, 150.00);   -- Jane Smith ordered 1 Headphones

-- 11. Queries for analysis

-- Calculate Average Order Value
SELECT AVG(total_amount) AS average_order_value FROM orders;

-- Count Orders by Status
SELECT order_status AS status, COUNT(*) AS order_count FROM orders GROUP BY order_status;

-- Find Highest Priced Product
SELECT product_id, name, price FROM products WHERE price = (SELECT MAX(price) FROM products);

-- Calculate Total Quantity Sold per Product
SELECT p.product_id, p.name, SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_id;

-- List Customers with Total Amount Spent
SELECT c.customer_id, c.first_name, c.last_name, SUM(od.price_per_product * od.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id;

-- Retrieve Customer Order Details (Delivered orders only)
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered';

-- Complex Join with Aggregation (Customer Orders and Amount Spent)
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(o.order_id) AS total_orders, 
    SUM(od.price_per_product * od.quantity) AS total_amount_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN order_details od ON o.order_id = od.order_id
GROUP BY c.customer_id
ORDER BY total_amount_spent DESC;

-- #### Reflection Questions 1
-- After completing the joins, reflect on the following:
-- - How does joining tables help you get a fuller picture of customer orders and product information?
-- By joining the customers table with the orders table, we can retrieve not just the order data but also customer details like name, email, and address
-- - Which joins were most challenging to understand? Why?
-- LEFT JOIN: because it includes all records from the left table (e.g., orders), even if there is no matching record in the right table
-- - How could joining tables and using aggregations be useful for reporting in an e-commerce application?
-- By joining orders with order_details and using SUM(), you can calculate total sales for each day

-- #### Reflection 2
-- - How do the tables work together to create a full picture of customers and orders?
-- Each order works together to make everything work  
-- - Why are foreign keys essential in linking different tables in a relational database?
-- Foreign keys enforce referential integrity between tables
-- - What challenges did you face in designing this schema?
-- I faced the biggest chagllend forgetting the small things 

-- #### Reflection Questions 3
-- Once you’ve completed the queries, consider the following:
-- How do aggregate functions like `SUM()` and `AVG()` help you gain insights into the data?
-- Aggregate functions like SUM() and AVG() are invaluable in summarizing large datasets
-- What insights could you gather from combining multiple functions (e.g., `SUM()` and `DATE()`)?
-- Combining multiple functions like SUM() and DATE() can provide more granular insights that are time-sensitive and actionable
-- Why might limiting results (e.g., to the top 5) be useful in reporting for an e-commerce store?
-- For instance, if you are analyzing sales, limiting the query to the top 5 products
