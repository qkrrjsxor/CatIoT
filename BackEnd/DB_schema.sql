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
    schedule_count INT NOT NULL,
    schedule_time1 TIME,
    schedule_time2 TIME,
    schedule_time3 TIME,
    schedule_time4 TIME,
    schedule_time5 TIME,
    schedule_amount1 INT,
    schedule_amount2 INT,
    schedule_amount3 INT,
    schedule_amount4 INT,
    schedule_amount5 INT,
    FOREIGN KEY (cat_id) REFERENCES cat(cat_id)
);

-- meal eaten table
CREATE TABLE IF NOT EXISTS meal_eaten(
	meal_id INT AUTO_INCREMENT PRIMARY KEY,
    cat_id INT NOT NULL,
    meal_date TIMESTAMP NOT NULL,
    meal_amount INT NOT NULL,
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

SELECT * from cat;