CREATE DATABASE Student_list;
Use Student_list;
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age TINYINt(5),
    enrollment_date DATE,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
	is_active BOOLEAN
   );
   
   CREATE TABLE Tran (
   amount_float FLOAT,
   amount_decimal DECIMAL(10,2)
   );
   
   
   CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock TINYINT(10)
);  

INSERT INTO products (name, description, price, stock)
VALUES 
('Laptop', 'A high-end laptop', 1200.00, 4),
('Smartphone', 'A latest model smartphone', 800.00, 2),
('Headphones', 'Noise-canceling headphones', 150.00, 10),
('Tablet', 'A lightweight tablet', 500.00, 10),
('Monitor', '4K Ultra HD monitor', 300.00, 5);

  CREATE TABLE my_Events (
  event_name  VARCHAR(100),
  event_date TIMESTAMP,
  event_time Time,
  event_dataTime DATETIME,
  event_timestamp TIMESTAMP
  
  );
  
  INSERT INTO my_events
(`event_name`,
`event_date`,
`event_time`,
`event_dateTime`,
`event_timeStamp`)
VALUES
('Tech Conference AfroTech', '2024-11-13', '09:00:00', '2024-11-13 09:00:00', '09:00:00'),
('Tech Conference Launchpad Hiring', '2024-11-13', '09:00:00', '2024-11-13 09:00:00', '09:00:00');

select * from my_events 
-- Where event_date BETWEEN current_date() AND current_date() + 7;
WHERE event_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY) + INTERVAL 1 SECOND;

CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name_char CHAR(10),
    name_varchar VARCHAR(10)
);

INSERT INTO Users (name_char, name_varchar)
VALUES 
    ('Alice', 'Alice'),
    ('Bob', 'Bob'),
    ('Jonathan', 'Jonathan'); 
