-- 1. Create the database and use it
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- 2. Create the customers table
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

-- 3. Create the products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create the orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Create the order_details table
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_product DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 6. Insert sample customers
INSERT INTO customers (first_name, last_name, email, phone_number, city, state, zip_code)
VALUES 
('John', 'Doe', 'johndoe@example.com', '123-456-7890', 'Springfield', 'IL', '62701'),
('Jane', 'Smith', 'janesmith@example.com', '987-654-3210', 'Homer', 'AK', '99603');

INSERT INTO products (name, description, price, stock_quantity)
VALUES 
('Laptop', 'A high-performance laptop', 999.99, 50),
('Headphones', 'Noise-cancelling headphones', 199.99, 200),
('Smartphone', 'Latest model smartphone', 799.99, 100);

INSERT INTO orders (customer_id, total_amount)
VALUES 
(1, 1199.98);  -- John Doe orders Laptop and Headphones

INSERT INTO orders (customer_id, total_amount)
VALUES 
(1, 1199.98);  -- John Doe orders Laptop and Headphones

SELECT order_id, order_date
FROM orders
WHERE customer_id = 1;

SELECT p.name, od.quantity, od.price_per_product
FROM order_details od
JOIN products p ON od.product_id = p.product_id
WHERE od.order_id = 1;

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;  -- Update for Laptop

UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 2;  -- Update for Headphones
