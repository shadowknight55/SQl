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