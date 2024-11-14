-- Create the Database
CREATE DATABASE Web_Developer_Portfolio_Schema;

CREATE TABLE Users (
  user_id INT PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  profile_image VARCHAR(255),
  bio TEXT,
  location VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);   

CREATE TABLE Projects (
  project_id INT PRIMARY KEY,
  user_id INT,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  thumbnail VARCHAR(255),
  github_url VARCHAR(255),
  live_url VARCHAR(255),
  start_date DATE,
  end_date DATE,
  is_featured BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Skills (
  skill_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  category VARCHAR(50),
  icon VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Project_Categories (
  category_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT
);

CREATE TABLE Social_Links (
  link_id INT PRIMARY KEY,
  user_id INT,
  platform VARCHAR(50),
  url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Blog_Posts (
  post_id INT PRIMARY KEY,
  user_id INT,
  title VARCHAR(100) NOT NULL,
  content TEXT,
  slug VARCHAR(100),
  status ENUM('draft', 'published'),
  published_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Project_Collaborators (
  collaborator_id INT PRIMARY KEY,
  project_id INT,
  name VARCHAR(100) NOT NULL,
  role VARCHAR(50),
  github_profile VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

CREATE TABLE Certifications (
  certification_id INT PRIMARY KEY,
  user_id INT,
  name VARCHAR(100),
  issuing_organization VARCHAR(100),
  issue_date DATE,
  expiry_date DATE,
  credential_url VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Sample Data Insertion
-- Insert dummy data into Users table
INSERT INTO Users (user_id, username, email, password_hash, first_name, last_name, profile_image, bio, location)
VALUES
(1, 'johndoe', 'johndoe@example.com', 'hashedpassword123', 'John', 'Doe', 'profile1.jpg', 'Web developer with a passion for design.', 'New York, USA'),
(2, 'janedoe', 'janedoe@example.com', 'hashedpassword456', 'Jane', 'Doe', 'profile2.jpg', 'Full-stack developer and tech enthusiast.', 'San Francisco, USA');

-- Insert dummy data into Projects table
INSERT INTO Projects (project_id, user_id, title, description, thumbnail, github_url, live_url, start_date, end_date, is_featured)
VALUES
(1, 1, 'Portfolio Website', 'A personal portfolio website showcasing my projects and skills.', 'portfolio.jpg', 'https://github.com/johndoe/portfolio', 'https://johndoe.com', '2023-01-01', '2023-02-01', TRUE),
(2, 2, 'E-Commerce App', 'A fully functional e-commerce application built with React and Node.js.', 'ecommerce.jpg', 'https://github.com/janedoe/e-commerce', 'https://janedoe-shop.com', '2023-03-01', '2023-06-01', FALSE);

-- Insert dummy data into Skills table
INSERT INTO Skills (skill_id, name, category, icon)
VALUES
(1, 'JavaScript', 'Frontend', 'js_icon.png'),
(2, 'React', 'Frontend', 'react_icon.png'),
(3, 'Node.js', 'Backend', 'nodejs_icon.png'),
(4, 'MySQL', 'Database', 'mysql_icon.png');

-- Insert dummy data into Project_Categories table
INSERT INTO Project_Categories (category_id, name, description)
VALUES
(1, 'Web Development', 'Projects related to web design and development.'),
(2, 'Mobile Development', 'Projects related to mobile app development.'),
(3, 'Machine Learning', 'Projects involving data analysis and machine learning.');

-- Insert dummy data into Social_Links table
INSERT INTO Social_Links (link_id, user_id, platform, url)
VALUES
(1, 1, 'GitHub', 'https://github.com/johndoe'),
(2, 1, 'LinkedIn', 'https://linkedin.com/in/johndoe'),
(3, 2, 'GitHub', 'https://github.com/janedoe'),
(4, 2, 'LinkedIn', 'https://linkedin.com/in/janedoe');

-- Insert dummy data into Blog_Posts table
INSERT INTO Blog_Posts (post_id, user_id, title, content, slug, status, published_at)
VALUES
(1, 1, 'How to Build a Portfolio', 'In this blog post, I share the process of building a personal portfolio website.', 'how-to-build-a-portfolio', 'published', '2023-02-01'),
(2, 2, 'Understanding React Hooks', 'This article dives deep into React hooks and how to use them effectively.', 'understanding-react-hooks', 'draft', NULL);

-- Insert dummy data into Project_Collaborators table
INSERT INTO Project_Collaborators (collaborator_id, project_id, name, role, github_profile)
VALUES
(1, 1, 'Alice Smith', 'UI Designer', 'https://github.com/alicesmith'),
(2, 2, 'Bob Johnson', 'Backend Developer', 'https://github.com/bobjohnson');

-- Insert dummy data into Certifications table
INSERT INTO Certifications (certification_id, user_id, name, issuing_organization, issue_date, expiry_date, credential_url)
VALUES
(1, 1, 'Certified Web Developer', 'Udemy', '2022-01-15', '2025-01-15', 'https://udemy.com/certifications/johndoe-webdev'),
(2, 2, 'AWS Certified Solutions Architect', 'Amazon Web Services', '2023-05-10', '2026-05-10', 'https://aws.amazon.com/certifications/janedoe-architect');
