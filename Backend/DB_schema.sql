CREATE SCHEMA IF NOT EXISTS CIoT;

USE CIoT;

-- user table
CREATE TABLE IF NOT EXISTS user(
	user_id VARCHAR(20) NOT NULL PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    user_name VARCHAR(20) NOT NULL
);

-- cat table
CREATE TABLE IF NOT EXISTS cat(
	cat_id INT AUTO_INCREMENT PRIMARY KEY,
	user_id varchar(20) NOT NULL,
    cat_name varchar(20) NOT NULL,
    cat_age INT NOT NULL,
    cat_gender ENUM('male', 'female') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

-- meal schedule table
CREATE TABLE IF NOT EXISTS meal_schedule(
	schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    cat_id INT NOT NULL,
    meal_time TIME NOT NULL,
    meal_scheduled_amount INT NOT NULL,
    FOREIGN KEY (cat_id) REFERENCES cat(cat_id)
);

-- meal eaten table
CREATE TABLE IF NOT EXISTS meal_eaten(
	meal_id INT AUTO_INCREMENT PRIMARY KEY,
    cat_id INT NOT NULL,
    meal_date TIMESTAMP NOT NULL,
    meal_eaten_amount INT NOT NULL,
	FOREIGN KEY (cat_id) REFERENCES cat(cat_id)
);

-- toilet table
CREATE TABLE IF NOT EXISTS toilet(
	toilet_id INT AUTO_INCREMENT PRIMARY KEY,
    cat_id INT NOT NULL,
    toilet_time TIMESTAMP NOT NULL,
    toilet_type ENUM('pee', 'poo'),
    FOREIGN KEY (cat_id) REFERENCES cat(cat_id)
);