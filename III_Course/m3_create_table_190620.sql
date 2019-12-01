CREATE TABLE employee (
	empno		decimal(4)		PRIMARY KEY,
	ename		varchar(30)		NOT NULL,
    hiredate	date			NOT NULL,
    salary		int				NOT NULL,
    deptno		decimal(3)		NOT NULL,
    title		varchar(20)		NOT NULL
);

CREATE TABLE `db01`.`department` (
  `deptno` DECIMAL(4) NOT NULL,
  `dname` VARCHAR(30) NOT NULL,
  `mgrno` DECIMAL(4) NULL,
  PRIMARY KEY (`deptno`));
  
SHOW TABLE STATUS IN db01;
SHOW TABLES;
DESC employee;
  
CREATE TABLE emp_copy LIKE employee;
DESC emp_copy;
DROP TABLE emp_copy;