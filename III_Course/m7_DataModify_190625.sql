-- INSERT Statement
-- 1
INSERT INTO department (deptno, dname, mgrno)
VALUES 		(400, 'Research', 1001);
-- 2
INSERT INTO department
VALUES 		(500, 'Personnel', 1001);
-- 3
INSERT INTO department (deptno, dname)
VALUES 		(601, 'IT');
-- 4
INSERT INTO department
VALUES 		(602, 'IT', NULL);
-- 5 可同時二筆以上的紀錄新增
INSERT INTO department (deptno, dname, mgrno)
VALUES 		(603, 'HRD', 1003), (604, 'STK', NULL);
-- 6 新增紀錄包含日期
INSERT INTO employee
VALUES 		(1009, '孫悟空', '2013/11/10', 56000, 100, 'senior engineer');
-- 7 新增紀錄，使用日期函數
INSERT INTO employee
VALUES 		(1010, '李大文', CURDATE(), 89000, 200, 'manager');
-- 8 轉移資料
	-- 複製與employee一模一樣emp_copy的表格
    -- 1
CREATE TABLE emp_copy LIKE employee;
	-- 2
INSERT INTO emp_copy SELECT * FROM employee;
	-- 新增與來源表格不同欄位的新表格(emp_copy1)，不要title欄位
CREATE TABLE emp_copy1 LIKE employee;
ALTER TABLE emp_copy1 DROP title; 
ALTER TABLE emp_copy1 CHANGE empno empid decimal(4);
INSERT INTO emp_copy1 (empid, ename, deptno, hiredate, salary)
SELECT 		empno, ename, deptno, hiredate, salary
FROM 		employee
WHERE 		title NOT LIKE '%SA%';

-- UPDATE Statement，修改一筆或多筆資料
	-- 修改empno = 1008 的薪水to 45000
UPDATE emp_copy
SET		salary = 45000
WHERE	empno = 1008;
    -- 不加WHERE子句時，所有紀錄皆會修改，所以MySQL預設不給修改
    -- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
UPDATE emp_copy1
SET		hiredate  = CURDATE();
    -- 解決辦法
SET SQL_SAFE_UPDATES=0; -- 將安全裝置關掉
SET SQL_SAFE_UPDATES=1;
	-- 不允許subquery中所使用的表格與UPDATE的表格是相同的
    -- 14:53:45	UPDATE emp_copy SET salary = (SELECT salary     FROM emp_copy                 WHERE empno = 1006) WHERE empno = 1007	Error Code: 1093. You can't specify target table 'emp_copy' for update in FROM clause	0.000 sec
UPDATE emp_copy
SET salary = (SELECT salary
				FROM emp_copy
                WHERE empno = 1006)
WHERE empno = 1007;
	-- 解決方法 FROM emp_copy 替換成 FROM (SELECT* FROM emp_copy) AS e
UPDATE emp_copy
SET salary = (SELECT salary
				FROM (SELECT* FROM emp_copy) AS e
                WHERE empno = 1006)
WHERE empno = 1007;

	-- 將所有和員工編號為1001的薪資相同的員工，將其部門代號改變成員工編號為1003的部門編號
    -- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
UPDATE emp_copy
SET 	deptno = (SELECT deptno
				FROM employee
                WHERE empno = 1003)
WHERE salary = (SELECT 	salary
				FROM 	employee
                WHERE 	empno = 1001);
	-- 解決辦法: 將安全裝置關掉，SET SQL_SAFE_UPDATES=0;

-- DELETE Statement
DELETE FROM emp_copy
WHERE		empno = 1007; 
	-- 沒輸入Primary key，不給刪	
	-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
DELETE FROM emp_copy1;
	-- 解決辦法: 將安全裝置關掉，SET SQL_SAFE_UPDATES=0;
    -- 刪除員工編號 601至604的員工資料
DELETE FROM department
WHERE		deptno BETWEEN 601 AND 604;
	-- 刪除所有部門名稱為Accounting的員工
    -- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
DELETE FROM emp_copy
WHERE 		deptno = (SELECT 	deptno
						FROM	department
                        WHERE	dname = 'Accounting'); 
	-- 解決辦法: 將安全裝置關掉，SET SQL_SAFE_UPDATES=0;
    
-- TRUNCATE
TRUNCATE emp_copy1;












