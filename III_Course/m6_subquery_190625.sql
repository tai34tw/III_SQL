-- 找出所有薪資比'潘麗珍'高的員工
SELECT	ename, salary
FROM	employee
WHERE	salary > (SELECT salary
					FROM employee
					WHERE ename = '潘麗珍'
					);
-- 找出所有職稱和員工編號1002相同且薪資比員工編號1005的員工
SELECT	ename, title, salary
FROM	employee
WHERE	title = (SELECT title
					FROM employee
					WHERE empno = 1002
                )
AND		salary > (SELECT salary
					FROM employee
					WHERE empno = 1005
					);
-- 找出所有最低薪資比部門代號為200最低薪資高的部門
SELECT		deptno, MIN(salary) AS 'Minimum Salary'
FROM		employee
GROUP BY 	deptno
HAVING 		MIN(salary) > (SELECT	MIN(salary)
							FROM	employee
                            WHERE	deptno = 200
							);
-- 找出部門代號為100的每位員工其薪資佔部門代號為100所有員工薪資的百分比
SELECT  ename, title, salary,
		ROUND (salary / 
				(SELECT SUM(salary)
                FROM	employee
                WHERE 	deptno = 100)*100, 1) AS 'percentage'
FROM	employee
WHERE 	deptno = 100;
-- 找出部分代號為100的每位員工其薪資佔部門代號為100所有員工薪資的百分比
SELECT  ename, title, salary,
		ROUND (salary / t.total * 100, 1) AS 'percentage'
FROM	employee, (SELECT 	SUM(salary) AS 'total'
					FROM    employee
					WHERE 	deptno = 100) AS t
WHERE 	deptno = 100;
-- Subquery 出現多列資料會出現錯誤alter 
SELECT  ename, title, salary
FROM	employee
WHERE	salary = (SELECT 	MIN(salary)
				  FROM      employee
				 GROUP BY 	deptno); 
                 
-- Multiple-Row Subquery
-- 找出職稱不是'senior engineer'且薪資比任何其中一個senior engineer薪資來得低的員工
-- 1
SELECT  ename, title, salary
FROM 	employee
WHERE 	salary < ANY
				(SELECT 	salary
				 FROM      	employee
				 WHERE 		title = 'senior engineer')
AND		title != 'senior engineer';
-- 2
SELECT  ename, title, salary
FROM 	employee
WHERE 	salary < (SELECT 		max(salary)
				  FROM      	employee
				  WHERE 		title = 'senior engineer')
AND		title != 'senior engineer';
-- 找出職稱不是'senior engineer'且薪資比所有senior engineer薪資來得低的員工
-- 1
SELECT  ename, title, salary
FROM 	employee
WHERE 	salary < ALL
				(SELECT 	salary
				 FROM      	employee
				 WHERE 		title = 'senior engineer')
AND		title != 'senior engineer';
-- 2
SELECT  ename, title, salary
FROM 	employee
WHERE 	salary < (SELECT 		min(salary)
				  FROM      	employee
				  WHERE 		title = 'senior engineer')
AND		title != 'senior engineer';
-- 找出所有是主管的員工
SELECT  ename
FROM 	emp
WHERE	empno IN 
				(SELECT DISTINCT mgrno
				FROM emp);
-- 找出不是主管的員工   
-- 失敗例子
SELECT  ename
FROM 	emp
WHERE	empno NOT IN 
				(SELECT DISTINCT mgrno
				FROM emp);
-- 成功例子               
SELECT  ename
FROM 	emp
WHERE	empno NOT IN 
				(SELECT DISTINCT mgrno
				FROM emp
                WHERE mgrno IS NOT NULL);

-- Correlated Subquery
-- 找出部門代號為100的每位員工其薪資佔部門代號為100所有員工薪資的百分比
SELECT  e.ename, e.title, e.salary,
		ROUND (salary/ 
				(SELECT SUM(salary)
                FROM	employee
                WHERE 	deptno = e.deptno) *100, 1) AS 'percentage'
FROM	employee AS e
WHERE 	e.deptno = 100;
-- 找出每個部門薪資最低的員工
-- 1
SELECT  ename, salary, deptno
FROM	employee AS e
WHERE 	salary in	
			(SELECT 	MIN(salary)
			 FROM 		employee
             GROUP BY 	deptno
             HAVING 	deptno = e.deptno);
-- 2
SELECT  ename, salary, deptno
FROM	employee AS e
WHERE 	salary in	
			(SELECT 	MIN(salary)
			 FROM 		employee
             WHERE 		deptno = e.deptno);
             
-- CREATE TABLE with query
CREATE TABLE	emp100 AS
SELECT 			empno, ename, salary*12 AS 'annualSalary', hiredate
FROM 			employee
WHERE			deptno = 100;
  
