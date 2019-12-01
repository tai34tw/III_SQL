CREATE DATABASE homework;
CREATE TABLE food (
	no			char(5)		PRIMARY KEY,
    name		varchar(30)	NOT NULL,
    expiredate 	datetime	NOT NULL,
    placeid		char(2)		NOT NULL,
    price		int			unsigned,
    catalog		varchar(20)	NOT NULL
);
DESC food;
DROP TABLE food;

CREATE TABLE place (
	no		char(2)			PRIMARY KEY,
	name	varchar(20)		NOT NULL
);
DESC place;
DROP TABLE place;

CREATE TABLE food1 LIKE food;
ALTER TABLE food1 ADD place 