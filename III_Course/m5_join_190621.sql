SELECT ename, dname 
from emp, dept;

SELECT ename, dname 
from emp CROSS JOIN dept; -- CROSS JOIN

SELECT ename, dname 
from emp, dept
WHERE emp.deptno  = dept.deptno; 				-- Equal JOIN

SELECT ename, eptno, name 
from emp, dept
WHERE emp.deptno  = dept.deptno; 				-- 無法跑，因為eptno在emp, dept皆有，統分不清

SELECT emp.ename, dept.dname 
from emp, dept
WHERE emp.deptno  = dept.deptno; 				-- SELECT 表格.欄位，以註明欄位來源較佳

SELECT emp.ename, dept.dname 
from emp JOIN dept
ON emp.deptno  = dept.deptno; 					-- Equal JOIN 之 ANSI 寫法

SELECT emp.ename, dept.dname 
from emp JOIN dept
USING (deptno); 								-- Equal JOIN 之 JOIN USING 寫法

SELECT emp.ename, dept.dname 
from emp NATURAL JOIN dept; 					-- Equal JOIN 之 NATURAL JOIN寫法


SELECT ename, dname, title 
from emp, dept
WHERE emp.deptno  = dept.deptno 				
AND title = 'engineer'; 						-- 新增篩title稱為'engineer'

    
SELECT emp.ename, dept.dname, title 
from emp JOIN dept
ON emp.deptno  = dept.deptno 
AND title = 'engineer';							-- 新增篩title稱為'engineer' 之 ANSI 寫法

    
SELECT e.ename, d.dname 
from emp AS e JOIN dept AS d
ON e.deptno  = d.deptno; 						-- 將表格設為別名，並在後續SELECT指令中使用別名


SELECT e.ename, d.dname, c.cname 
from emp AS e JOIN dept AS d
ON e.deptno  = d.deptno
JOIN city AS c
ON d.cityno  = c.cityno; 						-- JOIN 3個表格	

    
SELECT e.ename, d.dname, e.salary, g.level 
FROM emp e, dept d, grade g
WHERE e.deptno = d.deptno
AND e.salary BETWEEN g.lowest AND g.highest;		-- 找出所有員工姓名，所屬部門，薪資及薪資等級


SELECT e.ename, e.deptno, d.dname 
from emp AS e LEFT OUTER JOIN dept AS d
ON e.deptno = d.deptno; 						-- LEFT OUTER JOIN，e.dptno

SELECT e.ename, d.dname 
from emp AS e, dept AS d
WHERE e.deptno *= d.deptno;						-- 原LEFT OUTER JOIN 語法為 *= 不再適用了

SELECT e.ename, d.deptno, d.dname 
from emp AS e LEFT OUTER JOIN dept AS d
ON e.deptno = d.deptno; 						-- LEFT OUTER JOIN，d.dptno ，可比較上述結果差別
													-- e之deptno有值，d之deptn則無值
    
SELECT e.ename, e.deptno, d.dname 
from emp AS e LEFT OUTER JOIN dept AS d
ON e.deptno = d.deptno 
UNION    
SELECT e.ename, d.deptno, d.dname 
from emp AS e RIGHT OUTER JOIN dept AS d
ON e.deptno = d.deptno; 						-- 用 UNION 結合LEFT OUTER JOIN及 RIGHT  OUTER JOIN 實作 FULL  OUTER JOIN

    
SELECT worker.ename AS 'worker name', 
	   manager.ename AS 'manager name'
FROM emp AS worker, emp AS manager
WHERE worker.mgrno = manager.mgrno;  				-- SELF JOIN，找出每個員工的主管 