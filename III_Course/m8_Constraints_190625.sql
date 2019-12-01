-- Column-level constraint:限制條件直接寫在欄位的後面
CREATE TABLE emp1 (
	empno		decimal(4)		PRIMARY KEY,
	ename		varchar(30)		NOT NULL,
    hiredate	date			NOT NULL,
    salary		int				NOT NULL,
    email		varchar(30)		UNIQUE,
    deptno		decimal(3)		NOT NULL,
    title		varchar(20)		NOT NULL DEFAULT 'engineer',
-- 設置FOREIGN KEY
  CONSTRAINT 	emp_deptno_fk FOREIGN KEY (deptno)
  REFERENCES	department (deptno)
);
-- Table-level constraint:限制條件寫在表格的最後面
CREATE TABLE `db01`.`department` (
  `deptno` DECIMAL(4) NOT NULL,
  `dname` VARCHAR(30) NOT NULL,
  `mgrno` DECIMAL(4) NULL,
  PRIMARY KEY (`deptno`));

-- 新增資料時，若欄位未給值時，可使用Default給予值
-- Explicit default
-- 1 給DEFAULT
INSERT INTO dept
VALUES (600, 'Public Relations', DEFAULT);
-- 2 不給給DEFAULT，但列欄位名稱
INSERT INTO dept (deptno, dname)
VALUES (600, 'Public Relations');
-- 3
UPDATE 	dept
SET 	cityno =  DEFAULT
WHERE 	deptno = 500;

-- 測試 Unique & forien key
 INSERT INTO 	emp1
		VALUEs	(1002, '孫悟空', '2013/11/10', '56000','gg@gmail.com', '100',  'senior engineer'); 

-- email 為唯一值，欲輸入之已存在，無法新增
-- Error Code: 1062. Duplicate entry 'gg@gmail.com' for key 'email'
INSERT INTO 	emp1
		VALUEs	(1003, '孫悟空', '2013/11/10', '56000','gg@gmail.com', '100',  'senior engineer'); 
-- 欲輸入的值因parent表格之forien key的值不存在，無法新增
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`db01`.`emp1`, CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `department` (`deptno`))
INSERT INTO 	emp1
		VALUEs	(1004, '孫悟空', '2013/11/10', '56000','gg5@gmail.com', '600',  'senior engineer'); 
-- 當 child表格與parent表格還有相關聯紀錄(forien key)時，parent表格的紀錄是無法被刪除的
-- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`db01`.`emp1`, CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `department` (`deptno`))
DELETE FROM department
WHERE  deptno = 100;

-- 將emp1_FK的UPADTE設成CASCADE
ALTER TABLE `db01`.`emp1` 					-- 先刪除FK
DROP FOREIGN KEY `emp_deptno_fk`;
ALTER TABLE `db01`.`emp1` 					-- 再新增FK
ADD CONSTRAINT `emp_deptno_fk`
  FOREIGN KEY (`deptno`)
  REFERENCES `db01`.`department` (`deptno`)
  ON UPDATE CASCADE;
    
-- 將emp1_FK的DELETE設成CASCADE
ALTER TABLE `db01`.`emp1`  					-- 先刪除FK
DROP FOREIGN KEY `emp_deptno_fk`;
ALTER TABLE `db01`.`emp1` 					-- 再新增FK
ADD CONSTRAINT `emp_deptno_fk`
  FOREIGN KEY (`deptno`)
  REFERENCES `db01`.`department` (`deptno`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- AUTO_INCREMENT
-- 1
CREATE TABLE mem (
	memno	INT			PRIMARY KEY AUTO_INCREMENT,
    mname	VARCHAR(30)	NOT NULL
 );
INSERT INTO mem (mname) VALUES ('David Ho'), ('Maria Wang'), ('Pam Pan'), ('Tina Lee'), ('Jean Tsao');
-- 2
CREATE TABLE mem (
	memno	INT			PRIMARY KEY AUTO_INCREMENT,
    mname	VARCHAR(30)	NOT NULL
 ) AUTO_INCREMENT = 100;     -- 設定初始值為100