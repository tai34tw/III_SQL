SELECT * FROM employee;

-- 建立VIEW
-- 1
CREATE VIEW empvu100
AS SELECT 	empno, ename, salary
FROM 		employee
WHERE 		deptno = 100;
-- 2
CREATE VIEW emlvu100
AS SELECT 	empno AS id, ename AS name, salary*12 AS 'annual_salary'
FROM 		employee
WHERE 		deptno = 100;
-- 3 
CREATE VIEW emlvu100_1 (id, name, annual_salary)
AS SELECT 	empno, ename, salary*12 
FROM 		employee
WHERE 		deptno = 100;
-- 4 
CREATE VIEW dept_sum_vw (name, minsal, maxsal, avgsal)
AS SELECT 	d.dname, min(salary), max(salary), avg(salary)
FROM 		employee AS e, department AS d 
WHERE 		e.deptno = d.deptno
GROUP BY	d.dname;

-- 使用VIEW維護資料
UPDATE empvu100
SET ename = '孫悟淨'
WHERE empno = 1009;
-- 當VIEW無紀錄資料，雖child表格有，雖執行成功，但也無法改
-- -- 0 row(s) affected Rows matched: 0  Changed: 0  Warnings: 0
SELECT * FROM empvu100;
UPDATE empvu100
SET ename = '孫大為'
WHERE empno = 1003;
-- 當VIEW無該欄，雖child表格有，但也無法改
-- Error Code: 1054. Unknown column 'title' in 'field list'
SELECT * FROM empvu100;
UPDATE empvu100
SET title = 'SA'
WHERE empno = 1009;
-- 可透過 VIEW 刪child表格之紀錄
DELETE FROM empvu100 WHERE empno = 1009;

-- CHECK_OPTION
CREATE VIEW emp_sal_vw				-- 1 創造VIEW
AS SELECT 	empno, ename, salary
FROM 		employee
WHERE 		salary <= 40000
WITH CHECK OPTION;					
SELECT * FROM emp_sal_vw;			-- 2 檢視
-- Error Code: 1369. CHECK OPTION failed 'db01.emp_sal_vw'
UPDATE emp_sal_vw					-- 3 更新超過CHECK OPTION的值
SET salary = 40001
WHERE empno = 1002;


